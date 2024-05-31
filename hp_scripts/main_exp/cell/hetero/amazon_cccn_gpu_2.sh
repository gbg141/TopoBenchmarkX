datasets=( amazon_ratings )

seeds=(32 64 128)

for seed in ${seeds[*]}
do 
  for dataset in ${datasets[*]}
  do
  python ../../../topobenchmarkx/train.py \
    dataset=$dataset \
    model=cell/cccn \
    model.optimizer.lr=0.001 \
    model.feature_encoder.out_channels=$seed \
    model.backbone.n_layers=1,2,3,4 \
    model.feature_encoder.proj_dropout=0.25,0.5 \
    dataset.parameters.data_seed=0,3,5,7,9 \
    dataset.parameters.batch_size=1 \
    dataset.transforms.graph2cell_lifting.max_cell_length=10 \
    model.readout.readout_name="NoReadOut,PropagateSignalDown" \
    logger.wandb.project=TopoBenchmarkX_Cellular \
    trainer.max_epochs=1000 \
    trainer.min_epochs=50 \
    trainer.devices=\[2\] \
    trainer.check_val_every_n_epoch=1 \
    callbacks.early_stopping.patience=50 \
    tags="[MainExperiment]" \
    --multirun &
done
done
