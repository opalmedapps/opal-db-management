"""Various utility functions."""

from pathlib import Path


def read_sql_as_str(file: Path) -> str:
    """
    Reads the contents of a given sql file, and returns it as a string.

    Args:
        file: The path to the sql file.

    Returns:
        str: The string content of the sql file.
    """
    sql_content = ''
    # Read in SQL content from handle
    with Path(file).open(encoding='ISO-8859-1') as file_handle:
        sql_content += file_handle.read()
        file_handle.close()
    return sql_content
