function d=edit_distance_osa_keylist(s,t)
  % EDIT_DISTANCE_OSA_KEYLIST calculates the optimal string alignment (OSA)
  % edit distance for cell arrays of (string) keys, e.g. 
  %   edit_distance_damerau_keylist({'the','quick','brown','fox'},{'the','lazy','dog'})
  %
  % This code is part of the work described in [1]. In [1], edit distances
  % are applied to match linguistic descriptions that occur when referring
  % to objects (in order to achieve joint attention in spoken human-robot /
  % human-human interaction).
  %
  % [1] B. Schauerte, G. A. Fink, "Focusing Computational Visual Attention
  %     in Multi-Modal Human-Robot Interaction," in Proc. ICMI,  2010.
  %
  % @author: B. Schauerte
  % @date:   2010
  % @url:    http://cvhci.anthropomatik.kit.edu/~bschauer/
  
  % Copyright 2010 B. Schauerte. All rights reserved.
  % 
  % Redistribution and use in source and binary forms, with or without 
  % modification, are permitted provided that the following conditions are 
  % met:
  % 
  %    1. Redistributions of source code must retain the above copyright 
  %       notice, this list of conditions and the following disclaimer.
  % 
  %    2. Redistributions in binary form must reproduce the above copyright 
  %       notice, this list of conditions and the following disclaimer in 
  %       the documentation and/or other materials provided with the 
  %       distribution.
  % 
  % THIS SOFTWARE IS PROVIDED BY B. SCHAUERTE ''AS IS'' AND ANY EXPRESS OR 
  % IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED 
  % WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE 
  % DISCLAIMED. IN NO EVENT SHALL B. SCHAUERTE OR CONTRIBUTORS BE LIABLE 
  % FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
  % CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
  % SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR 
  % BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, 
  % WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
  % OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
  % ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  % 
  % The views and conclusions contained in the software and documentation
  % are those of the authors and should not be interpreted as representing 
  % official policies, either expressed or implied, of B. Schauerte.
  
  m=numel(s);
  n=numel(t);
  
  d=zeros(m+1,n+1);
  
  % initialize distance matrix
  for i=0:m % deletion
    d(i+1,1)=i;
  end
  for j=0:n % insertion
    d(1,j+1)=j;
  end
  
  for j=2:n+1
    for i=2:m+1
      if strcmp(s{i-1}, t{j-1})
        cost = 0;
      else
        cost = 1;
      end
      
      d(i,j)=min([ ...
        d(i-1,j) + 1, ...     % deletion
        d(i,j-1) + 1, ...     % insertion
        d(i-1,j-1) + cost ... % substitution
        ]);
      
      if (i-1)>1 && (j-1)>1 && strcmp(s{(i-1)}, t{(j-1)-1}) && strcmp(s{(i-1)-1}, t{j-1})
        d(i,j) = min([ ... % transposition
          d(i,j), ...
          d(i-2,j-2) + cost, ...
          ]);
      end
    end
  end
  
  d=d(m+1,n+1);
