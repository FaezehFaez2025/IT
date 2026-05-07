# Knowledge Base Subgraph Extractor

This script extracts subgraphs from a knowledge base (e.g., Wikidata) by traversing multi-hop neighborhoods around seed entities. It produces (subject, predicate, object) triples that form the subgraph surrounding each entity.

## Setup

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
python -m pip install --upgrade pip
PYTHONNOUSERSITE=1 python -m pip install SPARQLWrapper tqdm openai python-dotenv
```

## Usage

### Arguments

- `--multiple_samples` — Extract `--num_samples` subgraphs, each rooted at a different randomly selected entity.
- `--num_samples` — Target count of samples.
- `--max_hops` — Maximum traversal depth from each seed.
- `--parallel` — Distribute work across threads; use with `--num_threads`.
- `--num_threads` — Worker thread count when `--parallel` is set.
- `--controlled_extraction` — Expand each seed’s neighborhood with inline filtering at every step; does not postpone filtering to later stages.
- `--num_neighbors_per_hop` — How many neighbors to take at each hop.
- `--source` — Knowledge base backend.
- `--resume_generation` — Resume an interrupted run by skipping entities that already have output files.
- `--type_qid` — Category from which seed entities are randomly sampled, specified as a Wikidata QID. A few examples:

  | QID | Entity Type |
  |-----|-------------|
  | Q5 | Human |
  | Q515 | City |
  | Q11424 | Film |
  | Q3918 | University |
  | Q8502 | Mountain |

### Example

```bash
python knowledge_base_triple_extractor.py --multiple_samples --num_samples 200 --max_hops 4 --parallel --num_threads 5 --controlled_extraction --num_neighbors_per_hop 6 --source wikidata --type_qid Q5 --resume_generation
```

# Text Description Generator for Extracted Knowledge Graphs

This script generates natural language text descriptions for extracted knowledge graphs. 

- `--model` — Model to use (e.g. `gpt-3.5-turbo` or `deepseek-ai/DeepSeek-V3.2`).
- `--llm_provider` — LLM provider to use: `chatgpt` or `deepseek`.

```bash
python generate_text_from_kg.py --model deepseek-ai/DeepSeek-V3.2 --llm_provider deepseek --postfix "_triples.txt" --num_threads 2 --skip_existing
```

# Entity Expansion Blacklist Curation

Some entities in a knowledge graph are not worth expanding during traversal. Their outgoing connections tend to be generic and add little useful context. This script evaluates a single entity at a time. It fetches the entity's outgoing triples, applies rule-based filtering to remove obvious noise, and then asks an LLM to decide whether the remaining triples are informative. Entities where all triples are deemed uninformative are added to a blacklist so they are not expanded during graph traversal.

```bash
python entity_expansion_evaluator.py Q5 --model gpt-4o --batch_size 1
```
