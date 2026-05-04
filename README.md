# NeoGraphRAG

*Description will be added in the future.*

## Getting Started

To use NeoGraphRAG, follow these steps to initialize and set up the repository.

### Setting Up the Environment

1. Create the environment:

```bash
conda create --name NeoGraphRAG_env python=3.10
```
2. Activate it:

```bash
conda activate NeoGraphRAG_env
```

#### Installing Requirements for Running GraphRAG

1. Install Poetry by running:

	```bash
	pip install poetry
	```

2. Run the following command to install the required dependencies from the `GraphRAG-Next` folder using Poetry:

	```bash
	poetry install --directory GraphRAG-Next
	```

#### Installing Requirements for Running LightRAG

To install the required dependencies for LightRAG, run the following command:

```bash
pip install -e ./LightRAG
```

### Setting Up the OpenAI API Key

In the `.env` file located in the root of the repository, replace the placeholder with your actual OpenAI API key:

```env
OPENAI_API_KEY=your_openai_api_key_here
```
### Initializing GraphRAG

To set up GraphRAG, execute the initialization script:

   ```bash
   python initialize_graphrag.py
   ```

## Indexing Input Text with LightRAG and GraphRAG

To index your input text using **LightRAG** and **GraphRAG**, execute the following command. Make sure to replace the placeholder text within the quotes with your own text:

```bash
python perform_indexing.py --text "YOUR_INPUT_TEXT_HERE"
```

**Output Locations:**

- **LightRAG:** The constructed graph will be saved in the `LightRAG/output` directory.
- **GraphRAG:** The indexed results will be stored in `GraphRAG-Next/ragtest/output/artifacts`.

