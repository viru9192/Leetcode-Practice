class Solution:
    def romanToInt(self, s: str) -> int:
        val = {'I': 1, 'V': 5, 'X': 10, 'L': 50, 'C': 100, 'D': 500, 'M': 1000}
        ans = 0
        for i, ch in enumerate(s):
            v = val[ch]
            if i+1 < len(s) and v < val[s[i+1]]:
                ans -= v
            else:
                ans += v
        return ans