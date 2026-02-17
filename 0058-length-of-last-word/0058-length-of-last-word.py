class Solution:
    def lengthOfLastWord(self, s: str) -> int:
        last = len(s.strip().split()[-1])
        return last