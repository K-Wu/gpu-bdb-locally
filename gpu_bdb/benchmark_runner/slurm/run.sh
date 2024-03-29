#!/bin/bash

ACCOUNT=rapids
PARTITION=backfill
NODES=1

IMAGE=/lustre/fsw/rapids/gpu-bdb/containers/gpu-bdb-20210211.sqsh
DATA_PATH="/lustre/fsw/rapids"
MOUNT_PATH="/gpu-bdb-data/"
GPU_BDB_HOME="$HOME/gpu-bdb"

rm *.out
rm -rf $HOME/dask-local-directory/*

srun \
    --account $ACCOUNT \
    --partition $PARTITION \
    --nodes $NODES \
    --job-name ${ACCOUNT}-gpubdb:run_bench \
    --time 120 \
    --container-mounts $DATA_PATH:$MOUNT_PATH,$HOME:$HOME \
    --container-image=$IMAGE \
    bash -c "$GPU_BDB_HOME/gpu_bdb/benchmark_runner/slurm/run_bench.sh"
