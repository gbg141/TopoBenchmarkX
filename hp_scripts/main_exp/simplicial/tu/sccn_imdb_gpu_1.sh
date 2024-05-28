datasets=( 'IMDB-MULTI' )

lrs=(0.001)

for lr in ${lrs[*]}
do 
    for dataset in ${datasets[*]}
    do
    python ../../../topobenchmarkx/train.py \
        dataset=$dataset \
        model=simplicial/sccn \
        model.optimizer.lr=$lr \
        model.feature_encoder.out_channels=32,64,128 \
        model.backbone.n_layers=1,2,3,4 \
        model.feature_encoder.proj_dropout=0.25,0.5 \
        dataset.parameters.data_seed=0,3,5,7,9 \
        dataset.parameters.batch_size=128 \
        model.readout.readout_name="NoReadOut,PropagateSignalDown" \
        dataset.transforms.graph2simplicial_lifting.signed=True \
        logger.wandb.project=TopoBenchmarkX_Simplicial \
        trainer.max_epochs=500 \
        trainer.min_epochs=50 \
        trainer.check_val_every_n_epoch=5 \
        trainer.devices=\[1\] \
        callbacks.early_stopping.patience=10 \
        tags="[MainExperiment]" \
        --multirun &
    done
done

python ../../../topobenchmarkx/train.py \
    dataset=$dataset \
    model=simplicial/sccn \
    model.optimizer.lr=0.01 \
    model.feature_encoder.out_channels=32,64,128 \
    model.backbone.n_layers=1,2,3,4 \
    model.feature_encoder.proj_dropout=0.25,0.5 \
    dataset.parameters.data_seed=0,3,5,7,9 \
    dataset.parameters.batch_size=128 \
    model.readout.readout_name="NoReadOut,PropagateSignalDown" \
    dataset.transforms.graph2simplicial_lifting.signed=True \
    logger.wandb.project=TopoBenchmarkX_Simplicial \
    trainer.max_epochs=500 \
    trainer.min_epochs=50 \
    trainer.check_val_every_n_epoch=5 \
    trainer.devices=\[1\] \
    callbacks.early_stopping.patience=10 \
    tags="[MainExperiment]" \
    --multirun 

