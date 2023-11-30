"""Custom operations file for version controlling other SQL entities."""
from typing import Any, Type

from alembic.operations import MigrateOperation, Operations


class ReplaceableObject:  # noqa: WPS306
    """Generic class for holding textual definitions of replaceable entities."""

    def __init__(self, name: str, sqltext: str) -> None:
        """Initialize with the identifier and textual definition of the entity to be created/replaced/dropped.

        Args:
            name: identifier for the entity
            sqltext: MySQL definition of the base operation
        """
        self.name = name
        self.sqltext = sqltext


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
    def drop_trigger(cls: Type['CreateTriggerOp'], operations: Operations, replaceable_obj: ReplaceableObject) -> Any:
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
