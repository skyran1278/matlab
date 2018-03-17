function k = AssembleK(first, last, varargin)
% �A�Ω� chain bar
  % �o��x�}�j�p
  kSize = nargin * 2 + 2;

  % �o��s�x�}
  Kzero = zeros(kSize);

  firstK = Kzero;
  vararginK = Kzero;
  lastK = Kzero;

  firstK(1 : 4, 1 : 4) = first;

  lastK(kSize - 3 : kSize, kSize - 3 : kSize) = last;


  for index = 1 : nargin - 2

    vararginKWithIndex = Kzero;

    % �Pı�i�H�A²��
    vararginKWithIndex(index * 2 + 1 : index * 2 + 4, index * 2 + 1 : index * 2 + 4) = varargin{index};

    vararginK = vararginK + vararginKWithIndex;

  end


  k = firstK + vararginK + lastK;


end