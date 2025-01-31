"""Custom operations file for version controlling other SQL entities."""
from typing import Any, Type

from alembic.operations import MigrateOperation, Operations


class ReplaceableObject:
    """Generic class for holding textual definitions of replaceable entities.

    Design copied from Alembic cookbook: https://alembic.sqlalchemy.org/en/latest/cookbook.html#replaceable-objects
    """

    def __init__(self, name: str, sql_text: str) -> None:
        """Initialize with the identifier and textual definition of the entity to be created/replaced/dropped.

        Args:
            name: identifier for the entity
            sql_text: MySQL definition of the base operation
        """
        self.name = name
        self.sql_text = sql_text


class ReversibleOp(MigrateOperation):
    def __init__(self, target: ReplaceableObject):
        self.target = target

    @classmethod
    def invoke_for_target(cls, operations: Operations, target: ReplaceableObject) -> Any:
        op = cls(target)
        return operations.invoke(op)

    def reverse(self) -> MigrateOperation:
        raise NotImplementedError()

    @classmethod
    def _get_object_from_version(cls, operations: Operations, ident: str) -> Any:
        version, objname = ident.split('.')

        script = operations.get_context().script

        if script:
            module = script.get_revision(version).module
            return getattr(module, objname)

        raise ValueError('script directory not found')

    @classmethod
    def replace(
        cls,
        operations: Operations,
        target: ReplaceableObject,
        replaces: str | None = None,
        replace_with: str | None = None,
    ) -> None:

        if replaces:
            old_obj = cls._get_object_from_version(operations, replaces)
            drop_old = cls(old_obj).reverse()
            create_new = cls(target)
        elif replace_with:
            old_obj = cls._get_object_from_version(operations, replace_with)
            drop_old = cls(target).reverse()
            create_new = cls(old_obj)
        else:
            raise TypeError('replaces or replace_with is required')

        operations.invoke(drop_old)
        operations.invoke(create_new)


@Operations.register_operation('create_trigger')
class CreateTriggerOp(MigrateOperation):
    """Create a Trigger."""

    def __init__(self, replaceable_obj: ReplaceableObject) -> None:
        """Extract the name and sql_text from the operation object.

        Args:
            replaceable_obj: a ReplaceableObject or other class wrapper with name and sql_text fields.
        """
        self.name = replaceable_obj.name
        self.sql_text = replaceable_obj.sql_text

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
        return DropTriggerOp(self.name, sql_text=self.sql_text)


@Operations.register_operation('drop_trigger')
class DropTriggerOp(MigrateOperation):
    """Drop a Trigger."""

    def __init__(self, replaceable_obj: ReplaceableObject) -> None:
        """Extract the name and sql_text from the operation object.

        Args:
            replaceable_obj: a ReplaceableObject or other class wrapper with name and sql_text fields.
        """
        self.name = replaceable_obj.name
        self.sql_text = replaceable_obj.sql_text

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
        return CreateTriggerOp(self.name, sql_text=self.sql_text)


@Operations.implementation_for(CreateTriggerOp)
def create_trigger(operations: Operations, operation: CreateTriggerOp) -> None:
    """Public implementation of the CreateTrigger operation.

    Args:
        operations: Alembic Operations instance (context in which the migration is being performed)
        operation: CreateTriggerOp instance
    """
    operations.execute('CREATE TRIGGER {0} {1}'.format(operation.name, operation.sql_text))


@Operations.implementation_for(DropTriggerOp)
def drop_trigger(operations: Operations, operation: CreateTriggerOp) -> None:
    """Public implementation of the DropTrigger operation.

    Args:
        operations: Alembic Operations instance (context in which the migration is being performed)
        operation: DropTriggerOp instance
    """
    operations.execute('DROP TRIGGER IF EXISTS {0}'.format(operation.name))


@Operations.register_operation('create_procedure', 'invoke_for_target')
@Operations.register_operation('replace_procedure', 'replace')
class CreateProcedureOp(ReversibleOp):
    def reverse(self) -> MigrateOperation:
        return DropProcedureOp(self.target)


@Operations.register_operation('drop_procedure', 'invoke_for_target')
class DropProcedureOp(ReversibleOp):
    def reverse(self) -> MigrateOperation:
        return CreateProcedureOp(self.target)


@Operations.implementation_for(CreateProcedureOp)
def create_procedure(operations: Operations, operation: ReversibleOp) -> None:
    operations.execute('CREATE FUNCTION {name} {definition}'.format(
        name=operation.target.name,
        definition=operation.target.sql_text,
    ))


@Operations.implementation_for(DropProcedureOp)
def drop_procedure(operations: Operations, operation: ReversibleOp) -> None:
    operations.execute('DROP FUNCTION {0}'.format(operation.target.name))
