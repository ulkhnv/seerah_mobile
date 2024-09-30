# Seerah mobile

## Project Setup
This project uses Flutter 3.24.1 and several code generation tools. Follow these steps to get started:

1. **Makefile:** This project includes a `Makefile` to simplify common tasks: for example setup:
    ```bash
    make setup
    ```

2. **Flutter Version Management (FVM):** Ensure you have FVM installed. If not, follow the instructions at [FVM installation link]. Then, use FVM to set the correct Flutter version:
    ```bash
    fvm use 3.24.1
   ```

3. **Project Dependencies & Code Generation:** This project leverages `freezed` and `json_serializable` for efficient data modeling and JSON handling. Run the following command to install dependencies and generate the necessary code:
    ```bash
    make generate
    ```