#!/bin/bash

# Get the directory where the script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$SCRIPT_DIR"

# Default GPU
GPU_ID="0"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --gpu)
      GPU_ID="$2"
      shift 2
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

"$SCRIPT_DIR/prepare_dataset.sh" || exit 1

# Step 6: Remove saves folder in LLaMA-Factory
echo "Step 6: Removing saves folder in LLaMA-Factory..."
cd "$SCRIPT_DIR/LLaMA-Factory"
rm -rf saves

# Step 7: Run training
echo "Step 7: Running training..."
CUDA_VISIBLE_DEVICES="$GPU_ID" FORCE_TORCHRUN=1 llamafactory-cli train examples/train_full/qwen2.5_full_sft.yaml

# Step 8: Test finetuned model
echo "Step 8: Testing finetuned model..."
cd "$SCRIPT_DIR/LLaMA-Factory"
CUDA_VISIBLE_DEVICES="$GPU_ID" python infer_knowledge_graph.py --num_params 1.5B --use_finetuned

echo "Pipeline completed!" 