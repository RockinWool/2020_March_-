import networkx as nx
import matplotlib.pyplot as plt
from PIL import Image
from scipy.integrate import odeint as ODE
import numpy as np
from scipy.integrate import solve_ivp as SIVP

def sim(S0=1000,I0=1,R0=0,beta=0.2,gamma=0.1,t0=0,tmax=100,dt=1):
    #Sは未感染者(人),Iは感染者(人),Rは治癒者(人)
    t = np.arange(t0,tmax,dt)  #関数の使う形に時間の設定を調整
    Var = (S0,I0,R0)#初期状態の設定
    ret = ODE(SIR,Var,t,args=(beta,gamma))
    plot_graph(t,ret,"t","SI")
    
#↓以下関数の定義部分
def SIR(Var,t,beta,gamma):
    S = Var[0]
    I = Var[1]
    R = Var[2]
    N = S+I+R
    dSdt = -beta*S*I/N
    dIdt =  beta*S*I/N - gamma*I
    dRdt = gamma*I
    return (dSdt,dIdt,dRdt) 
#↓以下描画部分
def plot_graph(t_list, Var_list, t_label, Sim_label):
    plt.xlabel(t_label)  #x軸の名前
    plt.ylabel(Sim_label)  #y軸の名前
    plt.grid()  #点線の目盛りを表示
    S_list = Var_list[:,0]
    I_list = Var_list[:,1]
    R_list = Var_list[:,2]
    plt.plot(t_list,S_list)
    plt.plot(t_list,I_list)
    plt.plot(t_list,R_list)
    plt.show()
#↓以下デバッグ用
if __name__ == "__main__":
    sim()