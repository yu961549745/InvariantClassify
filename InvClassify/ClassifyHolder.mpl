$ifndef _CLASSIFY_HOLDER_
$define _CLASSIFY_HOLDER_

ClassifyHolder:=module()
    local   ieqCode,sols,unsolvedSols;
    export  reset,      # 重置状态
            addSol,     # 新增解
            getSols,    # 获取解
            addUnsolvedSol,
            getUnsolvedSols,
            getIeqCode; # 获取不变量方程的编号
    
    reset:=proc()
        ieqCode:=0;
        sols:={};
        unsolvedSols:={};
        return;
    end proc:

    addSol:=proc(s::InvSol)
        flogf[1]("添加不变量");
        flog[1](s:-rep);
        sols:=sols union {s};
        return;
    end proc:

    getSols:=proc()
        return sols;
    end proc:

    getIeqCode:=proc()
        ieqCode:=ieqCode+1;
        return ieqCode;
    end proc:

    addUnsolvedSol:=proc(s)
        unsolvedSols:=unsolvedSols union {s};
        return;
    end proc:

    getUnsolvedSols:=proc()
        return unsolvedSols;
    end proc:

end module:

$endif
