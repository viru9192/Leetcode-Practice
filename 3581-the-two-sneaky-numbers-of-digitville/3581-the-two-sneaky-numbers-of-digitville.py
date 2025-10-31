class Solution:
    def getSneakyNumbers(self, nums: List[int]) -> List[int]:
        l = set()
        num = []
        for n in nums:
            if n in l:
                num.append(n)
            else:
                l.add(n)
        return num