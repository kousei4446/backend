const rankingService = require('../services/rankingService');

exports.getRankingList = async (req, res) => {
  try {
    const rankingList = await rankingService.getRankingList();
    console.log('[INFO] /api/rankings response:', rankingList);

    const isAllEmpty = ['hard', 'normal', 'easy'].every(
      level => !rankingList[level] || rankingList[level].length === 0
    );

    if (isAllEmpty) {
      return res.status(404).json({ message: 'ランキングが見つかりません' });
    }

    res.json(rankingList);
  } catch (err) {
    console.error('[ERROR] /api/rankings failed:', err);
    res.status(500).json({ message: 'サーバーエラーが発生しました' });
  }
};
