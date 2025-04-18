# SPDX-FileCopyrightText: Copyright (C) 2023 Opal Health Informatics Group at the Research Institute of the McGill University Health Centre <john.kildea@mcgill.ca>
#
# SPDX-License-Identifier: AGPL-3.0-or-later

"""Custom operations file for version controlling other SQL entities."""

from typing import Any, Final

from alembic.operations import MigrateOperation, Operations

INVOKE_FOR_TARGET: Final[str] = 'invoke_for_target'
REPLACE: Final[str] = 'replace'


class ReplaceableObject:
    """
    Generic class for holding textual definitions of replaceable entities.

    Design copied from Alembic cookbook: https://alembic.sqlalchemy.org/en/latest/cookbook.html#replaceable-objects
    """

    def __init__(self, name: str, sql_text: str) -> None:
        """
        Initialize with the identifier and textual definition of the entity to be created/replaced/dropped.

        Args:
            name: identifier for the entity
            sql_text: MySQL definition of the base operation
        """
        self.name = name
        self.sql_text = sql_text


class ReversibleOp(MigrateOperation):
    """
    Reversible operation for replaceable objects.

    Source: https://alembic.sqlalchemy.org/en/latest/cookbook.html#create-operations-for-the-target-objects
    """

    def __init__(self, target: ReplaceableObject):
        """
        Initialize the reversible operation for a replaceable object.

        Args:
            target: the replaceable object
        """
        self.target = target

    @classmethod
    def invoke_for_target(cls, operations: Operations, target: ReplaceableObject) -> Any:
        """
        Invoke the operation for the target replaceable object.

        Args:
            operations: the operations instance
            target: the replaceable object

        Returns:
            the return value of invoking the operation, if any
        """
        op = cls(target)
        return operations.invoke(op)

    def reverse(self) -> MigrateOperation:
        """
        Reverses the operation.

        Sub-classes need to implement this method.

        Raises:
            NotImplementedError: if the sub-class does not implement this method
        """
        raise NotImplementedError()

    @classmethod
    def replace(
        cls,
        operations: Operations,
        target: ReplaceableObject,
        replaces: str | None = None,
        replace_with: str | None = None,
    ) -> None:
        """
        Replace the existing element with an updated one.

        For example, to update a stored procedure, the existing one needs to be replaced
        by deleting the current one and creating the new one under the same name.

        Either `replaces` or `replaces_with` needs to be provided.

        Args:
            operations: the operations instance
            target: the target replaceable object
            replaces: a reference to the replaceable object to replace in the form migration_name.attribute
            replace_with: a reference to the replaceable object to replace with the given one (migration.attribute)

        Raises:
            TypeError: if neither the replace nor replace_with argument is provided
        """
        if replaces:
            old_obj = cls._get_object_from_version(operations, replaces)
            drop_old = cls(old_obj).reverse()
            create_new = cls(target)
        elif replace_with:
            old_obj = cls._get_object_from_version(operations, replace_with)
            drop_old = cls(target).reverse()
            create_new = cls(old_obj)
        else:
            message = 'replaces or replace_with is required'
            raise TypeError(message)

        operations.invoke(drop_old)
        operations.invoke(create_new)

    @classmethod
    def _get_object_from_version(cls, operations: Operations, ident: str) -> Any:
        version, objname = ident.split('.')

        script = operations.get_context().script

        if script:
            module = script.get_revision(version).module
            return getattr(module, objname)

        message = 'script directory not found'
        raise ValueError(message)


@Operations.register_operation('create_trigger', INVOKE_FOR_TARGET)
class CreateTriggerOp(ReversibleOp):
    """Create a Trigger."""

    def reverse(self) -> MigrateOperation:
        """
        Call the inverse method to reverse the effect of the CreateTrigger operation.

        Returns:
            Instance of MigrateOperation
        """
        return DropTriggerOp(self.target)


@Operations.register_operation('drop_trigger', INVOKE_FOR_TARGET)
class DropTriggerOp(ReversibleOp):
    """Drop a Trigger."""

    def reverse(self) -> MigrateOperation:
        """
        Call the inverse method to reverse the effect of the DropTrigger operation.

        Returns:
            Instance of MigrateOperation
        """
        return CreateTriggerOp(self.target)


@Operations.implementation_for(CreateTriggerOp)
def create_trigger(operations: Operations, operation: CreateTriggerOp) -> None:
    """
    Public implementation of the CreateTrigger operation.

    Args:
        operations: Alembic Operations instance (context in which the migration is being performed)
        operation: CreateTriggerOp instance
    """
    operations.execute(f'CREATE TRIGGER IF NOT EXISTS {operation.target.name} {operation.target.sql_text}')


@Operations.implementation_for(DropTriggerOp)
def drop_trigger(operations: Operations, operation: CreateTriggerOp) -> None:
    """
    Public implementation of the DropTrigger operation.

    Args:
        operations: Alembic Operations instance (context in which the migration is being performed)
        operation: DropTriggerOp instance
    """
    operations.execute(f'DROP TRIGGER IF EXISTS {operation.target.name}')


@Operations.register_operation('create_function', INVOKE_FOR_TARGET)
@Operations.register_operation('replace_function', REPLACE)
class CreateFunctionOp(ReversibleOp):
    """Create function operation."""

    def reverse(self) -> MigrateOperation:
        """
        Reverse the create function operation by returning an operation that drops the function.

        Returns:
            a drop function operation
        """
        return DropFunctionOp(self.target)


@Operations.register_operation('drop_function', INVOKE_FOR_TARGET)
class DropFunctionOp(ReversibleOp):
    """Drop function operation."""

    def reverse(self) -> MigrateOperation:
        """
        Reverse the drop function operation by returning an operation that creates the function.

        Returns:
            a create function operation
        """
        return CreateFunctionOp(self.target)


@Operations.implementation_for(CreateFunctionOp)
def create_function(operations: Operations, operation: CreateFunctionOp) -> None:
    """
    Execute the create function operation.

    Args:
        operations: the operations instance
        operation: the create function operation to execute
    """
    operations.execute(f'CREATE FUNCTION {operation.target.name} {operation.target.sql_text}')


@Operations.implementation_for(DropFunctionOp)
def drop_function(operations: Operations, operation: DropFunctionOp) -> None:
    """
    Execute the drop function operation.

    Args:
        operations: the operations instance
        operation: the drop function operation to execute
    """
    operations.execute(f'DROP FUNCTION {operation.target.name}')


@Operations.register_operation('create_procedure', INVOKE_FOR_TARGET)
@Operations.register_operation('replace_procedure', REPLACE)
class CreateProcedureOp(ReversibleOp):
    """Create stored procedure operation."""

    def reverse(self) -> MigrateOperation:
        """
        Reverse the create procedure operation by returning an operation that drops the procedure.

        Returns:
            a drop procedure operation
        """
        return DropProcedureOp(self.target)


@Operations.register_operation('drop_procedure', INVOKE_FOR_TARGET)
class DropProcedureOp(ReversibleOp):
    """Drop stored procedure operation."""

    def reverse(self) -> MigrateOperation:
        """
        Reverse the drop procedure operation by returning an operation that creates the procedure.

        Returns:
            a create procedure operation
        """
        return CreateProcedureOp(self.target)


@Operations.implementation_for(CreateProcedureOp)
def create_procedure(operations: Operations, operation: CreateProcedureOp) -> None:
    """
    Execute the create stored procedure operation.

    Args:
        operations: the operations instance
        operation: the create stored procedure operation to execute
    """
    operations.execute(f'CREATE PROCEDURE {operation.target.name} {operation.target.sql_text}')


@Operations.implementation_for(DropProcedureOp)
def drop_procedure(operations: Operations, operation: DropProcedureOp) -> None:
    """
    Execute the drop stored procedure operation.

    Args:
        operations: the operations instance
        operation: the drop stored procedure operation to execute
    """
    operations.execute(f'DROP PROCEDURE {operation.target.name}')
