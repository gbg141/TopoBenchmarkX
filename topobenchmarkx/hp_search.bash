#python train.py model.backbone.hidden_channels=32,64,128 model.backbone.n_layers=1,2 dataset.parameters.batch_size=64,128 dataset.parameters.data_seed=1,2,3 --multirun

#python train.py dataset=REDDIT-BINARY model=cwn model.backbone.hidden_channels=32,64,128 model.backbone.n_layers=1,2,3,4 dataset.parameters.batch_size=64,128 dataset.parameters.data_seed=1,2,3 --multirun
python train.py dataset=REDDIT-BINARY model=cwn model.optimizer.lr=0.1,0.01 model.optimizer.weight_decay=0,0.01 model.backbone.hid_channels=32,64,128 model.backbone.n_layers=1,2,3,4 dataset.parameters.batch_size=64,128 dataset.parameters.data_seed=3 --multirun

python train.py dataset=REDDIT-BINARY model=unignn2 model.optimizer.lr=0.1,0.01 model.optimizer.weight_decay=0,0.01 model.backbone.hidden_channels=32,64,128 model.backbone.n_layers=1,2,3,4 dataset.parameters.batch_size=64,128 dataset.parameters.data_seed=3 --multirun
#python train.py dataset=PROTEINS_TU +transforms.transform_chain_proteins_g2s=transforms.transform_chain_proteins_g2hp model=unignn2  --multirun