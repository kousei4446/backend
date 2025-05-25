const rankingModel = require('../models/rankingModel');
exports.getRankingList = async () => {
  const getTop10 = async (column) => {
    const rows = await rankingModel.getTop10ByColumn(column);

    console.log(`[DEBUG] ${column} rows:`, rows);  // ← 追加

    return rows.map((row, index) => ({
      userId: row.userId,
      userName: row.userName,
      rank: index + 1,
      clearNum: row.clearNum,
    }));
  };

  return {
    hard: await getTop10('hard_clear_num'),
    normal: await getTop10('normal_clear_num'),
    easy: await getTop10('easy_clear_num'),
  };
};
