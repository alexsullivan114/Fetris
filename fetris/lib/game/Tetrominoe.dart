enum Tetrominoe { STRAIGHT, SQUARE, T, L, J, S, Z }

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
    case Tetrominoe.J:
      return 3;
      break;
    case Tetrominoe.S:
      return 3;
      break;
    case Tetrominoe.Z:
      return 3;
      break;
  }

  return 0;
}

int tetrominoeWidth(Tetrominoe tetrominoe) {
  switch (tetrominoe) {
    case Tetrominoe.STRAIGHT:
      return 1;
      break;
    case Tetrominoe.SQUARE:
      return 2;
      break;
    case Tetrominoe.T:
      return 3;
      break;
    case Tetrominoe.L:
      return 2;
      break;
    case Tetrominoe.J:
      return 2;
      break;
    case Tetrominoe.S:
      return 2;
      break;
    case Tetrominoe.Z:
      return 2;
      break;
  }

  return 0;
}
