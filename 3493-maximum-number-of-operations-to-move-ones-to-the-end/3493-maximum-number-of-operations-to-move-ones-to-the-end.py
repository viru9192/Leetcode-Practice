class Solution:
    def maxOperations(self, s: str) -> int:
        ans = 0
        ones = 0
        n = len(s)

        for i, c in enumerate(s):
            if c == '1':
                ones += 1
            else:
                # c == '0'
                # this zero is a boundary zero if it's at the end
                # or followed by a '1'
                if i + 1 == n or s[i + 1] == '1':
                    ans += ones

        return ans  