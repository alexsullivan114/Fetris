enum Tetrominoe { STRAIGHT, SQUARE, T, L, S }

int tetrominoeHeight(Tetrominoe tetrominoe) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      return 4;
      break;
    case Tetrominoe.SQUARE:
      return 2;
      break;
    case Tetrominoe.T:
      return 2;
      break;
    case Tetrominoe.L:
      return 3;
      break;
    case Tetrominoe.S:
      return 3;
      break;
  }

  return 0;
}
