"""Custom operations file for version controlling other SQL entities."""
from typing import Any, Type

from alembic.operations import MigrateOperation, Operations


class ReplaceableObject:
    """Generic class for holding textual definitions of replaceable entities.

    Design copied from Alembic cookbook: https://alembic.sqlalchemy.org/en/latest/cookbook.html#replaceable-objects
    """

    def __init__(self, name: str, sqltext: str = '') -> None:
        """Initialize with the identifier and textual definition of the entity to be created/replaced/dropped.

        Args:
            name: identifier for the entity
            sqltext: MySQL definition of the base operation
        """
        self.name = name
        self.sqltext = sqltext


class ReversibleOp(MigrateOperation):
    def __init__(self, target: ReplaceableObject):
        self.target = target

    @classmethod
    def invoke_for_target(cls, operations: Operations, target: ReplaceableObject) -> Any:
        op = cls(target)
        return operations.invoke(op)

    def reverse(self) -> MigrateOperation:
        raise NotImplementedError()


@Operations.register_operation('create_trigger')
class CreateTriggerOp(MigrateOperation):
    """Create a Trigger."""

    def __init__(self, replaceable_obj: ReplaceableObject) -> None:
        """Extract the name and sqltext from the operation object.

        Args:
            replaceable_obj: a ReplaceableObject or other class wrapper with name and sqltext fields.
        """
        self.name = replaceable_obj.name
        self.sqltext = replaceable_obj.sqltext

    @classmethod
    def create_trigger(cls: Type['CreateTriggerOp'], operations: Operations, replaceable_obj: ReplaceableObject) -> Any:
        """Issue a "CREATE TRIGGER" instruction.

        Args:
            operations: Alembic Operations instance (context in which the migration is being performed)
            replaceable_obj: The trigger object to be created

        Returns:
            Any return from the invocation of the operation, though not strictly used
        """
        op = cls(replaceable_obj)
        return operations.invoke(op)

    def reverse(self) -> MigrateOperation:
        """Call the inverse method to reverse the effect of the CreateTrigger operation.

        Returns:
            Instance of MigrateOperation
        """
        return DropTriggerOp(self.name, sqltext=self.sqltext)


@Operations.register_operation('drop_trigger')
class DropTriggerOp(MigrateOperation):
    """Drop a Trigger."""

    def __init__(self, replaceable_obj: ReplaceableObject) -> None:
        """Extract the name and sqltext from the operation object.

        Args:
            replaceable_obj: a ReplaceableObject or other class wrapper with name and sqltext fields.
        """
        self.name = replaceable_obj.name
        self.sqltext = replaceable_obj.sqltext

    @classmethod
    def drop_trigger(cls: Type['DropTriggerOp'], operations: Operations, replaceable_obj: ReplaceableObject) -> Any:
        """Issue a "DROP TRIGGER" instruction.

        Args:
            operations: Alembic Operations instance (context in which the migration is being performed)
            replaceable_obj: The trigger object to be created

        Returns:
            Any return from the invocation of the operation, though not strictly used
        """
        op = cls(replaceable_obj)
        return operations.invoke(op)

    def reverse(self) -> MigrateOperation:
        """Call the inverse method to reverse the effect of the DropTrigger operation.

        Returns:
            Instance of MigrateOperation
        """
        return CreateTriggerOp(self.name, sqltext=self.sqltext)


@Operations.implementation_for(CreateTriggerOp)
def create_trigger(operations: Operations, operation: CreateTriggerOp) -> None:
    """Public implementation of the CreateTrigger operation.

    Args:
        operations: Alembic Operations instance (context in which the migration is being performed)
        operation: CreateTriggerOp instance
    """
    operations.execute('CREATE TRIGGER {0} {1}'.format(operation.name, operation.sqltext))


@Operations.implementation_for(DropTriggerOp)
def drop_trigger(operations: Operations, operation: CreateTriggerOp) -> None:
    """Public implementation of the DropTrigger operation.

    Args:
        operations: Alembic Operations instance (context in which the migration is being performed)
        operation: DropTriggerOp instance
    """
    operations.execute('DROP TRIGGER IF EXISTS {0}'.format(operation.name))


@Operations.register_operation('create_procedure', 'invoke_for_target')
class CreateProcedureOp(ReversibleOp):
    def reverse(self) -> ReversibleOp:
        return DropProcedureOp(self.target)


@Operations.register_operation('drop_procedure', 'invoke_for_target')
class DropProcedureOp(ReversibleOp):
    def reverse(self) -> ReversibleOp:
        return CreateProcedureOp(self.target)


@Operations.implementation_for(CreateProcedureOp)
def create_procedure(operations: Operations, operation: ReversibleOp) -> None:
    operations.execute("CREATE FUNCTION %s %s" % (
        operation.target.name,
        operation.target.sqltext,
    ))


@Operations.implementation_for(DropProcedureOp)
def drop_procedure(operations: Operations, operation: ReversibleOp) -> None:
    operations.execute("DROP FUNCTION %s" % operation.target.name)
