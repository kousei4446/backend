const rankingService = require('../services/rankingService');
exports.getRankingList = async (req, res) => {
  const rankingList = await rankingService.getRankingList();
  if (!rankingList) {
    return res.status(404).json({ message: 'ランキングが見つかりません' });
  }
  res.json(rankingList);
};
