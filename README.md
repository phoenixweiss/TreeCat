# TreeCat

TreeCat is a simple Bash utility that outputs the structure of a project and saves the contents of all files into a single text file with clearly marked sections.

## Features

- Outputs the directory structure using `tree`.
- Saves the contents of each file in the structure with file paths and content separated by lines.
- Automatically ignores files and directories specified in `.gitignore`.
- Allows you to add custom ignore patterns for files or directories.
- Saves everything in a single output file (`output.txt` by default).

## Prerequisites

Make sure the following tools are installed on your system:

- `tree`: Used to display the directory structure. You can install it with:

  - On Ubuntu/Debian:

    ```bash
    sudo apt-get install tree
    ```

  - On macOS (with Homebrew):

    ```bash
    brew install tree
    ```

  - On Windows (using Git Bash or Cygwin):

    ```bash
    pacman -S tree
    # or
    choco install tree
    ```

- `cat`: Standard tool for displaying file contents (usually pre-installed on most Unix-like systems).


## Installation

No installation is required. Just download or copy the script and make it executable:

```bash
chmod +x treecat.sh
```

## Usage

Run the script from the root directory of your project:

```bash
./treecat.sh
```

By default, the output will be saved to `output.txt`.

## Customization

You can customize the ignore patterns by modifying the `CUSTOM_IGNORE_PATTERNS` array within the script.

## Example Output

```txt
path/to/file.ext
--------------------------------------------------------------------------------
File contents here...
--------------------------------------------------------------------------------
path/to/another_file.ext
--------------------------------------------------------------------------------
Another file's contents...
--------------------------------------------------------------------------------
```

## License

This project is licensed under the MIT License.
