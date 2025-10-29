class Solution:
    def smallestNumber(self, n: int) -> int:
        a = 1
        while True:
            if 2**a <= n:
                a+=1
            else:
                break
        
        return 2**a -1