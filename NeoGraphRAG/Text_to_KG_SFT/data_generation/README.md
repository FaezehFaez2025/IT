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
pip install --upgrade pip
pip install SPARQLWrapper tqdm
```

## Usage

### Arguments

- `--multiple_samples` — Extract `--num_samples` subgraphs, each rooted at a different randomly selected entity.
- `--num_samples` — Target count of samples (here, 200).
- `--max_hops` — Maximum traversal depth from each seed.
- `--parallel` — Distribute work across threads; use with `--num_threads`.
- `--num_threads` — Worker thread count when `--parallel` is set.
- `--controlled_extraction` — Expand each seed’s neighborhood with inline filtering at every step (blacklist, rules, subject–predicate uniqueness); does not postpone filtering to later stages.
- `--num_neighbors_per_hop` — In controlled mode, how many neighbors to take at each hop (here, 6).
- `--source` — Knowledge base backend.
- `--type_qid` — Wikidata type Q-ID restricting eligible entities (e.g. `Q5` is **human**).
- `--resume_generation` — Only generate samples that are still missing output; skip entities that already have saved files.

### Example

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

# entity_expansion_evaluator.py

Evaluates if a Wikidata entity is worth expanding based on triple informativeness. First applies rule-based filtering, then uses LLM prompting on the remaining triples to determine if all are non-informative or if any informative triples exist.

```bash
python entity_expansion_evaluator.py Q5 --model gpt-4o --batch_size 1
```
