class Solution:
    def getSneakyNumbers(self, nums: List[int]) -> List[int]:
        lnum = set()
        dup_num = []
        for n in nums:
            if n in lnum:
                dup_num.append(n)
            else:
                lnum.add(n)
        return dup_num