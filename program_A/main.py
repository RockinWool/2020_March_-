import SIR_model
import numpy as np
#----初期設定エリア---#
S0=1000 #未感染者数
I0=1    #感染者数
R0=0    #治癒or死亡者数
beta=0.2       #感染率
gamma=0.1      #回復率・死亡率
t0 = 0       #開始時間
tmax = 200   #終了時間
dt = 1      #時間刻み幅
#---実行部分---#
SIR_model.sim(S0,I0,R0,beta,gamma,t0,tmax,dt)