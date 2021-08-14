function [f,c,fx,fu,fxx,fxu,fuu,cx,cu,cxx,cxu,cuu] = pendulum_dyn_cst(x,u,full_DDP)
% combine pendulum dynamics and cost
% use helper function finite_difference() to compute derivatives

if nargout == 2
    f = pendulum_dynamics(x,u);
    c = pendulum_cost(x, u);
else
    % state and control indices
    ix = 1:2;
    iu = 3;
    
%     % dynamics first derivatives
%     xu_dyn  = @(xu) pendulum_dynamics(xu(ix,:),xu(iu,:));
    J       = finite_difference_pendulum_dynamics([x; u]);
    fx      = J(:,ix,:);
    fu      = J(:,iu,:);
    
    
    % dynamics second derivatives
    if full_DDP
        %xu_Jcst = @(xu) finite_difference(xu_dyn, xu);
        JJ = finite_finite_dyncst_difference([x; u]);
        JJ = reshape(JJ, [2 3 size(J,2) size(J,3)]);
        JJ = 0.5*(JJ + permute(JJ,[1 3 2 4])); %symmetrize
        fxx = JJ(:,ix,ix,:);
        fxu = JJ(:,ix,iu,:);
        fuu = JJ(:,iu,iu,:);
    else
        [fxx,fxu,fuu] = deal([]);
    end


% for single derivative   for full_DDP == false
%     if full_DDP
%         xu_Jcst = @(xu) finite_difference(xu_dyn, xu);
%         JJ      = finite_difference(xu_Jcst, [x; u]);
%         JJ      = reshape(JJ, [2 3 size(J)]);
%         JJ      = 0.5*(JJ + permute(JJ,[1 3 2 4])); %symmetrize
%         fxx     = JJ(:,ix,ix,:);
%         fxu     = JJ(:,ix,iu,:);
%         fuu     = JJ(:,iu,iu,:);
%     else
%         [fxx,fxu,fuu] = deal([]);
%     end
%     
    % cost first derivatives
    %xu_cost = @(xu) pendulum_cost(xu(ix,:),xu(iu,:));
    J       = squeeze(finite_difference_pendulum_cost([x; u]));
    cx      = J(ix,:);
    cu      = J(iu,:);
    
    % cost second derivatives
    %xu_Jcst = @(xu) squeeze(finite_difference(xu_cost, xu));
    JJ      = finite_finite_pendulum_cost([x; u]);
    JJ      = 0.5*(JJ + permute(JJ,[2 1 3]));      %symmetrize
    cxx     = JJ(ix,ix,:);
    cxu     = JJ(ix,iu,:);
    cuu     = JJ(iu,iu,:);
    
    [f,c] = deal([]);
end