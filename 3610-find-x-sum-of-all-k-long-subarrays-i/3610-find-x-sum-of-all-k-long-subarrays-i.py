class Solution:
    def findXSum(self, nums: List[int], k: int, x: int) -> List[int]:
        n = len(nums)
        ans = []
        for i in range(n - k + 1):
            window = nums[i:i+k]
            cnt = Counter(window)  # value -> frequency in this window

            # Sort by: higher frequency first, then higher value
            top = sorted(cnt.items(), key=lambda p: (-p[1], -p[0]))[:x]

            # x-sum = keep only top x elements (by the rule), sum value * frequency
            ans.append(sum(val * freq for val, freq in top))
        return ans