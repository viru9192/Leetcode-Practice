class Solution:
    def minimumOneBitOperations(self, n: int) -> int:
        ans = 0
        while n:
            ans ^= n      # prefix XOR
            n >>= 1
        return ans