import numpy as np
import networkx as nx
import random


class Graph():
    def __init__(self, nx_G, is_directed, p, q):
        self.G = nx_G
        self.is_directed = is_directed
        self.p = p
        self.q = q

    def node2vec_walk(self, walk_length, start_node):
        '''
        Simulate a random walk starting from start node.
        '''
        G = self.G
        alias_nodes = self.alias_nodes
        alias_edges = self.alias_edges

        #print 'Start walk'
        walk = [start_node]
        weight_index=['test']
        cur_nbrs=[]
        while len(walk) < walk_length:
            cur = walk[-1]
            cur_nbrs_i=[]
            cur_nbrs=[]
            #print 'walk', walk[-1]
            list_neighbors = G.neighbors(cur)
            #list_neighbors2 = G.neighbors(cur)
            #print 'len list_neigh', len(list(list_neighbors2))
            #print 'neighborhs ', cur
            #for iets in list_neighbors:
            #    print iets
            #print ' '
            if len(walk) > 1:
                #print 'runned weighted'
                for i in list_neighbors:
                    for j in range(0,len(G[cur][i])):
                        #print 'i', i
                        #print 'j', j
                        #print 'cur', cur
                        #print 'G[cur][i]', G[cur][i]
                        #print 'G[cur][i][j]', G[cur][i][j]
                       
                        
                        if G[cur][i][j]['weight'] >= G[walk[-2]][cur][weight_index[-1]]['weight']:
                            cur_nbrs_i.append(i)  
                            #print 'runned and found weighted higher time'
            else:
                cur_nbrs_i = sorted(G.neighbors(cur))
                #print 'runned unweighted'
            #print 'cur_nbrs ', cur
            #for iets in cur_nbrs:
            #    print iets
            #print ' '   
            
            cur_nbrs = list(set(cur_nbrs_i)) 
            #print 'len cur nbrs', len(cur_nbrs)
            if cur in cur_nbrs:
                cur_nbrs.remove(cur)
                
            if len(cur_nbrs) > 0:
                if len(walk) == 1:
                    cur_nbrs_len =len(cur_nbrs)
                    alias_edges_0_i = alias_nodes[cur][0]
                    alias_edges_1_i = alias_nodes[cur][1]
                    alias_edges_0 = alias_edges_0_i[0:cur_nbrs_len]
                    alias_edges_1 = alias_edges_1_i[0:cur_nbrs_len]
                    next = cur_nbrs[alias_draw(alias_edges_0, alias_edges_1)]
                    walk.append(next)   
                    #print 'next', next
                    #print 'cur', cur
                    # ORIGINAL: walk.append(cur_nbrs[alias_draw(alias_nodes[cur][0], alias_nodes[cur][1])])
                    #
                    weight_index.append(random.randint(0,len(G[cur][next])-1))
                else:
                    prev = walk[-2]
                    #print '--'
                    #print len(cur_nbrs)
                    #print alias_draw(alias_edges[(prev, cur)][0], alias_edges[(prev, cur)][1])
                    #for item in cur_nbrs:
                    #    print item
                    #print '--'
                    #print len(cur_nbrs)
                    #print 'alias edges 0', alias_edges[(prev, cur)][0]
                    #print 'alias edges 1', alias_edges[(prev, cur)][1]
                    #print alias_draw(alias_edges[(prev, cur)][0], alias_edges[(prev, cur)][1])
                    #print'prev', prev
                    #print 'cur', cur
                    #print '--'
                    cur_nbrs_len =len(cur_nbrs)
                    alias_edges_0_i = alias_edges[(prev, cur)][0]
                    alias_edges_1_i = alias_edges[(prev, cur)][1]
                    alias_edges_0 = alias_edges_0_i[0:cur_nbrs_len]
                    alias_edges_1 = alias_edges_1_i[0:cur_nbrs_len]
                    next = cur_nbrs[alias_draw(alias_edges_0, alias_edges_1)]
                    walk.append(next)
                    #print 'next', next
                    #print 'next', next
                    #print 'seen'
                    #print 'cur', cur
                    #print 'next', next
                    
                    weight_index.append(random.randint(0,len(G[cur][next])-1))
            else:
                break
            #print 'end iteration'
        return walk

    def simulate_walks(self, num_walks, walk_length, verbose=True):
        '''
        Repeatedly simulate random walks from each node.
        '''
        G = self.G
        walks = []
        nodes = list(G.nodes())
        if verbose == True:
            print 'Walk iteration:'
        for walk_iter in range(num_walks):
            if verbose == True:
                print str(walk_iter+1), '/', str(num_walks)
            random.shuffle(nodes)
            for node in nodes:
                walks.append(self.node2vec_walk(walk_length=walk_length, start_node=node))

        return walks

    def get_alias_edge(self, src, dst):
        '''
        Get the alias edge setup lists for a given edge.
        '''
        G = self.G
        p = self.p
        q = self.q

        #G = nx.Graph(G) ##--
        
        
        unnormalized_probs = []
        for dst_nbr in sorted(G.neighbors(dst)):
            if dst_nbr == src:
                #unnormalized_probs.append(G[dst][dst_nbr]['weight']/p)
                unnormalized_probs.append(1/p)
            elif G.has_edge(dst_nbr, src):
                #unnormalized_probs.append(G[dst][dst_nbr]['weight'])
                unnormalized_probs.append(1)
            else:
                #unnormalized_probs.append(G[dst][dst_nbr]['weight']/q)
                unnormalized_probs.append(1/q)
        norm_const = sum(unnormalized_probs)
        normalized_probs =  [float(u_prob)/norm_const for u_prob in unnormalized_probs]

        return alias_setup(normalized_probs)

    def preprocess_transition_probs(self):
        '''
        ###### unnormalized_probs= [G[node][nbr]['weight'] for nbr in sorted(G.neighbors(node))]
        Preprocessing of transition probabilities for guiding the random walks.
        '''
        G = self.G
        is_directed = self.is_directed       
        alias_nodes = {}
        
        #G = nx.Graph(G) ##--
    
        for node in G.nodes():
            count=[]
            [ count.append(1) for nbr in sorted(G.neighbors(node))] 
            unnormalized_probs = count                      
            norm_const = sum(unnormalized_probs)
            #print norm_const
            #unnormalized_probs= [G[node][nbr]['weight'] for nbr in sorted(G.neighbors(node))]
            normalized_probs =  [float(u_prob)/norm_const for u_prob in unnormalized_probs]
            alias_nodes[node] = alias_setup(normalized_probs)

        alias_edges = {}
        triads = {}

        if is_directed:
            for edge in G.edges():
                alias_edges[edge] = self.get_alias_edge(edge[0], edge[1])
        else:
            for edge in G.edges():
                alias_edges[edge] = self.get_alias_edge(edge[0], edge[1])
                alias_edges[(edge[1], edge[0])] = self.get_alias_edge(edge[1], edge[0])

        self.alias_nodes = alias_nodes
        self.alias_edges = alias_edges

        return


def alias_setup(probs):
    '''
    Compute utility lists for non-uniform sampling from discrete distributions.
    Refer to https://hips.seas.harvard.edu/blog/2013/03/03/the-alias-method-efficient-sampling-with-many-discrete-outcomes/
    for details
    '''
    K = len(probs)
    q = np.zeros(K)
    J = np.zeros(K, dtype=np.int)

    smaller = []
    larger = []
    for kk, prob in enumerate(probs):
        q[kk] = K*prob
        if q[kk] < 1.0:
            smaller.append(kk)
        else:
            larger.append(kk)

    while len(smaller) > 0 and len(larger) > 0:
        small = smaller.pop()
        large = larger.pop()

        J[small] = large
        q[large] = q[large] + q[small] - 1.0
        if q[large] < 1.0:
            smaller.append(large)
        else:
            larger.append(large)

    return J, q

def alias_draw(J, q):
    '''
    Draw sample from a non-uniform discrete distribution using alias sampling.
    '''
    K = len(J)

    kk = int(np.floor(np.random.rand()*K))
    if np.random.rand() < q[kk]:
        return kk
    else:
        return J[kk]