# knowledge_base_triple_extractor.py

## Requirements (InvertiTune data generation)

Scripts in this folder support the **InvertiTune** text-to-KG SFT data pipeline. Use **Python 3.9+**, allow network access (Wikidata SPARQL and optional LLM APIs), and install dependencies below. For the optional `--save` GUI on Linux, you may need `sudo apt install python3-tk`.

Create a conda environment:

```bash
conda create -n invertitune-data python=3.11 -y
```

Activate it:

```bash
conda activate invertitune-data
```

Install Python packages:

```bash
pip install --upgrade pip
pip install SPARQLWrapper tqdm openai python-dotenv
```

This Python script extracts triples (subject, predicate, object) from **Wikidata** or **YAGO** knowledge bases. It retrieves n-hop neighbors of a given entity and includes an optional GUI to select 
and save some of the triples.

## Usage

### Command-Line Arguments
- `--entity`: The entity ID to query (e.g., `Q12345` for Wikidata or `ACF_Fiorentina` for YAGO).
- `--hops`: The number of hops (default: 1).
- `--save`: Enable the GUI to select and save some of the triples.
- `--source`: The knowledge base to query (`wikidata` or `yago`). Default is `wikidata`.

### Example Commands

#### Query Wikidata
```bash
python knowledge_base_triple_extractor.py --entity Q12345 --hops 2 --save
```
#### Parallel Extraction (TBC)
```bash
python knowledge_base_triple_extractor.py --multiple_samples --num_samples 10 --max_hops 2 --source wikidata --ratio 0.3 --parallel --num_threads 4
```
#### Resume Generation
```bash
python knowledge_base_triple_extractor.py --multiple_samples --num_samples 200 --max_hops 4 --parallel --num_threads 5 --controlled_extraction --num_neighbors_per_hop 6 --source wikidata --type_qid Q5 --resume_generation
``` 
# generate_text_from_kg.py
```bash
python generate_text_from_kg.py --source wikidata --model deepseek-ai/DeepSeek-V3 --llm_provider deepseek --postfix "_triples.txt"
```

```bash
python generate_text_from_kg.py --source wikidata --model gpt-3.5-turbo --llm_provider chatgpt
```
## Skip Existing Flag
```bash
python generate_text_from_kg.py --source wikidata --model deepseek-ai/DeepSeek-V3 --llm_provider deepseek --postfix "_triples.txt" --num_threads 10 --skip_existing
```

# rule_based_triple_filtering.py
```bash
python rule_based_triple_filtering.py --source wikidata
```
# entity_triple_viewer.py

This script retrieves all relationships where the specified entity is the subject. It queries Wikidata to extract and display all triples associated with a given entity ID.

## Usage

```bash
python entity_triple_viewer.py Q6581097
```

Replace `Q6581097` with any Wikidata entity ID you want to explore.

# entity_expansion_evaluator.py

Evaluates if a Wikidata entity is worth expanding based on triple informativeness. First applies rule-based filtering, then uses LLM prompting on the remaining triples to determine if all are non-informative or if any informative triples exist.

```bash
python entity_expansion_evaluator.py Q5 --model gpt-4o --batch_size 1
```
