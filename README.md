# Custom Startup Script

This script automates the process of customizing the startup for your projects by cloning a Git repository and starting your project with ease, whether it's a Node.js or Python project.

## Features

- Clone Git repository
- Customize startup process for Node.js or Python projects
- Automated setup for dependencies
- Easy to configure and use

## How to Use

1. Clone or download this repository to your local machine:

    ```bash
    git clone https://github.com/JarsScript/docker-run.git
    ```
    or donwload the **docker-run.sh** file and add it to your root.

3. Open the `docker-run.sh` file in your preferred text editor.

4. Fill in the required variables according to the guide provided in the script comments:

    ```bash
    # -- Read guide -- #
    GIT_USERNAME=
    GIT_REPO=
    GIT_TOKEN=
    GIT_BRANCH=main
    IS_PUBLIC=false
    REBUILD_AFTER_CLONE=false
    EGG="node.js"
    PYTHON_SCRIPT="main.py"
    # ---- guide ---- #
    # Fill in the required variables before running the script
    ```

5. Ensure you have the necessary permissions to execute the script:

    ```bash
    chmod +x docker-run.sh
    ```

6. Run the script:

    ```bash
    ./docker-run.sh
    ```

## Guide

Before running the script, make sure to fill in the following variables:

- `GIT_USERNAME`: Your Git username.
- `GIT_REPO`: The URL of your Git repository.
- `GIT_TOKEN`: Your Git user token (if needed).
- `GIT_BRANCH`: The branch you want to clone (default is `main`).
- `IS_PUBLIC`: Set to `true` if your repository is public, otherwise set to `false`.
- `REBUILD_AFTER_CLONE`: Set to `true` if you want to rebuild npm packages after cloning.
- `EGG`: Choose the type of project ("node.js" or "python").
- `PYTHON_SCRIPT`: The startup file for Python projects (required if `EGG` is set to "python").

## Example Usage

```bash
./docker-run.sh
```
## Contributing
Contributions are welcome! If you have any suggestions, improvements, or bug fixes, feel free to open an issue or create a pull request.
