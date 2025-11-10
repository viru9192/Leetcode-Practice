class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        pos = defaultdict(list)
        vals = set()
        for i, x in enumerate(nums):
            if x > 0:
                pos[x].append(i)
                vals.add(x)

        parent = [-1]*n          # -1 => inactive; otherwise parent for DSU
        rank = [0]*n
        mark = [0]*n             # mark[root] = value v if this component already has a 'v' in current round

        def find(x):
            while parent[x] != x:
                parent[x] = parent[parent[x]]
                x = parent[x]
            return x

        def union(a, b, cur):
            ra, rb = find(a), find(b)
            if ra == rb: 
                return 0
            # if both components already contain a 'cur', merging removes one counted block
            dec = 1 if (mark[ra] == cur and mark[rb] == cur) else 0
            if rank[ra] < rank[rb]:
                ra, rb = rb, ra
            parent[rb] = ra
            if rank[ra] == rank[rb]:
                rank[ra] += 1
            # propagate mark for current v
            if mark[ra] == cur or mark[rb] == cur:
                mark[ra] = cur
            return dec

        ans = 0
        for v in sorted(vals, reverse=True):      # process high -> low
            for i in pos[v]:
                parent[i] = i                     # activate index
                mark[i] = v                       # this component now has a 'v'
                ans += 1                          # new v-block (might merge below)
                if i-1 >= 0 and parent[i-1] != -1:
                    ans -= union(i, i-1, v)
                if i+1 < n and parent[i+1] != -1:
                    ans -= union(i, i+1, v)

        return ans