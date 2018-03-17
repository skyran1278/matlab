function k = AssembleK(first, last, varargin)
% 適用於 chain bar
  % 得到矩陣大小
  kSize = nargin * 2 + 2;

  % 得到零矩陣
  Kzero = zeros(kSize);

  firstK = Kzero;
  vararginK = Kzero;
  lastK = Kzero;

  firstK(1 : 4, 1 : 4) = first;

  lastK(kSize - 3 : kSize, kSize - 3 : kSize) = last;


  for index = 1 : nargin - 2

    vararginKWithIndex = Kzero;

    % 感覺可以再簡化
    vararginKWithIndex(index * 2 + 1 : index * 2 + 4, index * 2 + 1 : index * 2 + 4) = varargin{index};

    vararginK = vararginK + vararginKWithIndex;

  end


  k = firstK + vararginK + lastK;


end