class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        
        # Case 1: There are already some 1s
        ones = sum(1 for x in nums if x == 1)
        if ones > 0:
            # Each non-1 takes exactly one operation using a neighbor 1
            return n - ones
        
        # Case 2: No 1s, we must create one from some subarray
        INF = 10**9
        best_len = INF
        
        # Try all subarrays, track gcd
        for i in range(n):
            g = nums[i]
            for j in range(i + 1, n):
                g = gcd(g, nums[j])
                if g == 1:
                    best_len = min(best_len, j - i + 1)
                    break  # no need to extend further from this i
        
        # If we never found a subarray with gcd 1, impossible
        if best_len == INF:
            return -1
        
        # (best_len - 1) ops to create first 1 + (n - 1) to spread it
        return (best_len - 1) + (n - 1)