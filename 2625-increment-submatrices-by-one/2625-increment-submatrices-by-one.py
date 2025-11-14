class Solution:
    def rangeAddQueries(self, n: int, queries: List[List[int]]) -> List[List[int]]:
        # create (n+1) x (n+1) diff array
        diff = [[0] * (n + 1) for _ in range(n + 1)]

        # apply each query as a 2d difference update
        for r1, c1, r2, c2 in queries:
            diff[r1][c1] += 1
            diff[r1][c2 + 1] -= 1
            diff[r2 + 1][c1] -= 1
            diff[r2 + 1][c2 + 1] += 1

        # prefix sum horizontally (row-wise)
        for i in range(n):
            for j in range(1, n):
                diff[i][j] += diff[i][j - 1]

        # prefix sum vertically (column-wise)
        for j in range(n):
            for i in range(1, n):
                diff[i][j] += diff[i - 1][j]

        # build the final matrix (ignore last row/col)
        mat = [[0] * n for _ in range(n)]
        for i in range(n):
            for j in range(n):
                mat[i][j] = diff[i][j]

        return mat      