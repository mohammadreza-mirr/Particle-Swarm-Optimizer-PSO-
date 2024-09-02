clc;
clear;
close all;

%% Problem Definition

CostFunction=@(x) Sphere(x);    

nVar=5;            

VarSize=[1 nVar]; 

VarMin=-10;       
VarMax= 10;        

%% PSO Parameters

MaxIt=500;     
nPop=20;

wmax=0.9;           
wmin=0.2;

c1=1.5;          
c2=1.5; 

VelMax=6;
VelMin=-6;

%% Initialization

particle.Position=[];
particle.Cost=[];
particle.Velocity=[];
particle.Best.Position=[];
particle.Best.Cost=[];

particle=repmat(particle,nPop,1);

GlobalBest.Cost=inf;

for i=1:nPop
    
    
    particle(i).Position=unifrnd(VarMin,VarMax,VarSize);
    
    particle(i).Velocity=zeros(VarSize);
    
    particle(i).Cost=CostFunction(particle(i).Position);
		
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    
    if particle(i).Best.Cost<GlobalBest.Cost
        
        GlobalBest=particle(i).Best;
        
    end
    
end

BestCost=zeros(MaxIt,1);

%% PSO Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        w(it)=wmax-((wmax-wmin)/MaxIt)*it;
        particle(i).Velocity = w(it)*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position);
       
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        particle(i).Cost = CostFunction(particle(i).Position);
		
        
        if particle(i).Cost<particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
           
            if particle(i).Best.Cost<GlobalBest.Cost
                
                GlobalBest=particle(i).Best;
                
            end
            
        end
        
    end
    
    BestCost(it)=GlobalBest.Cost;
    
    disp(['Iteration ' num2str(it)  ', Best Cost = ' num2str(BestCost(it))]);
    
  
end

%% Results

figure;
plot(BestCost,'LineWidth',2);
xlabel('Iteration');
ylabel('Best Cost');

