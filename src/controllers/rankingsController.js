exports.getRankingList = async (req, res) => {
  // 仮データ（実際は DB から取得してください）
  const sample = [
    { userId: "user001", userName: "Alice", rank: 1, correctNum: 42 },
    { userId: "user002", userName: "Bob", rank: 2, correctNum: 39 },
    { userId: "user003", userName: "Carol", rank: 3, correctNum: 35 },
  ];
  res.json(sample);
};
