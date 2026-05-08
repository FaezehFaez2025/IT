#!/bin/bash

# Wikidata SFT dataset preparation (runs from this script's directory)
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

echo "Step 1: Deleting data folder..."
rm -rf data

echo "Step 2: Preparing data..."
python prepare_data.py --data_folder ./data_generation/data --source wikidata --train_ratio 0.8 --triples_postfix "_triples.txt" --num_samples 1000

echo "Step 3: Building training dataset..."
python build_llama_factory_dataset.py --partition train

echo "Step 4: Building test dataset..."
python build_llama_factory_dataset.py --partition test

echo "Dataset preparation completed!"
