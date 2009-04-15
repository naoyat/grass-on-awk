#!/usr/bin/env gawk -f
#
# grass.awk - Grass on AWK, ver 0.06
#
# usage: awk -f grass.awk -v srcfile=foobar
#
BEGIN {
#   RS = "[vｖ]" ← うまくいかないね
    RS = "v"

    if (verbose ~ /^$/) verbose = 0

    _stack = ""
    _stock_id = 0

    print "====== Grass on AWK 0.06 ======"
    push("E")
    push("/@in")
    push(119) #"w"
    push("/@succ")
    push("/@out")

    true_func = "/2[0]0.2,"
    false_func = "/2[0]0.1,"

    # ソース読み込み
    while (getline < srcfile > 0) {
        ## 前処理
        gsub(/Ｗ/,"W")
        gsub(/ｗ/,"w")
        gsub(/[^Ww]/,"")

        # 文をパース
        if (verbose) printf("%s => %s\n", $0, pp($0));

        ## Function:
        if (/^w/) {
            N = split(read($0), ar, " ") # odd
            if (verbose) print "function."

            stock_id = stock(_stack)
            js = "/" ar[1] "[" _stock_id "]"
            for (i=2; i<=N; i+=2) {
                js = js ar[i] "." ar[i+1] ","
            }

            push(js)
            dump()
            continue
        }
        ## Applications:
        if (/^W/) {
            N = split(read($0), ar, " ") # even

            if (verbose) printf "applications."
            for (i=1; i<=N; i+=2) {
                proc = st( ar[i] )
                arg = st( ar[i+1] )
                if (verbose) printf("%d) apply (%d %d) c-a-d. (%s %s) ...\n", i, ar[i], ar[i+1], proc, arg);
                val = apply(proc, arg)
                if (verbose) printf(" => %s\n", val);
                push(val)
            }

            printf "\n"
            continue
        }
    }

    #
    fn = arg = pop()
    val = apply(fn, arg)
    print ""
    exit
}

#
# スタック関連の関数
#
function push(x)
{
    if (verbose) print "push " x;

    _stack = x ":" _stack
}

function pop(    var,ix)
{
    if (verbose) print "pop ";

    ix = index(_stack,":")
    if (ix > 0) {
        var = substr(_stack, 1, ix-1)
        _stack = substr(_stack, ix+1)
    } else {
        # スタックが空
        print "ERROR: _stack is empty." > "/dev/stderr"
        var = ""
    }

    if (verbose) printf("  => %s\n", var);
    return var
}

function dump(  N,a,i)
{
    if (verbose) {
        print "{"
        N = split(_stack, a, /:/)
        for (i=1; i<N; i++) print "  - " a[i];
        print "}"
    }
}

function st(ix,    N,a)
{
    N = split(_stack, a, /:/)
    if (1 <= ix && ix <= N) {
        return a[ix]
    } else {
        print "ERROR: out of bounds." > "/dev/stderr"
        return ""
    }
}


function stock(stack)
{
    _stack_stock[++_stock_id] = stack
    return _stock_id
}

function stack_at(stock_id)
{
    return _stack_stock[stock_id]
}

function is_primitive(fn)
{
    return (fn ~ /^\/@/) ? 1 : 0
}

function arity_of(fn,  b)
{
    if (is_primitive(fn)) return 1 # /@out, /@in, /@succ

    b = index(fn, "[")
    return 0 + substr(fn, 2, b-2)
}

function env_of(fn, b,e)
{
    b = index(fn,"[")
    e = index(fn,"]")
    stock_id = substr(fn, b+1, e-b-1)
    return stack_at( stock_id )
}

function body_of(fn, e)
{
    e = index(fn, "]")
    return substr(fn, e+1)
}

function apply_primitive(fn,arg,  name,line)
{
    name = substr(fn,3)
    if (name ~ /out/) {
        if (verbose) printf "OUT:"
        printf("%c", arg)
        if (verbose) printf "\n"
        return arg
    } else if (name ~ /in/) {
        getline line
        return ord(substr(line,1,1))
    } else if (name ~ /succ/) {
        if (verbose) printf("succ %s(%c) => %s(%c)\n", arg,arg, (arg+1)%256,(arg+1)%256)
        return (arg + 1) % 256 ###
    }
}

function apply_cmp(fn,arg)
{
    if (verbose) printf("APPLY COMPARISON/%d with arg:%s\n", fn, arg)
    return (0+fn == 0+arg) ? true_func : false_func
}

function apply(fn,arg, ar,as,N,i,  arity,env,new_env,body, proc,val,stack_bup, tmp)
{
    if (verbose) printf("(apply %s %s...)\n", fn, substr(arg,1,10))

    if (is_primitive(fn)) return apply_primitive(fn,arg)
    if (fn ~ /^[0-9]/) return apply_cmp(fn,arg)

    arity = arity_of(fn)
    env = env_of(fn)
    body = body_of(fn)

    new_env = arg ":" env

    if (arity > 1) {
        stock_id = stock(new_env)
        val = sprintf("/%d[%d]%s", arity-1, stock_id, body)

        if (verbose) printf("＜部分適用＞ %s => %s\n", fn, val)
        return val;
    }

    if (verbose) printf("= arity:%d, env:%s, body:%s\n", arity, env, body);
    stack_bup = _stack
    _stack = new_env
    if (verbose) print "closure:"
    dump()

    if (verbose) print "APPLY: executing body: "

    N = split(body,as,/,/);
    if (verbose) printf("body\"%s\" => %d exprs\n", body,N-1)
    for (i=1; i<N; i++) {
        split(as[i], ar, /\./)

        if (ar[1] == 0) {
            if (verbose) printf("%d) boolean.\n", i)
            val = st( ar[2] )
            push(val)
            dump()
        } else {
            proc = st( ar[1] )
            arg = st( ar[2] )

            dump()
            if (verbose) printf("%d) apply (%d %d) c-a-d. (%s %s) ...\n", i, ar[1], ar[2], proc, arg);
            val = apply(proc, arg)
            if (verbose) printf(" => %s\n", val);

            push(val)
        }
    }
    if (verbose) print "body end."
    dump()

    val = pop()
    _stack = stack_bup
    return val
}

#
# wWWwWww --> 1 2 1 1 2
# www --> 3
# WWww -> 2 1
#
function read(s, res, last,len,cnt,i,c)
{
    last = ""

    res = ""
    cnt = ""

    len = length(s)
    for (i=1; i<=len; i++) {
        c = substr(s,i,1)
        if (c == last) {
            cnt++
        } else {
            last = c
            res = res " " cnt
            cnt = 1
        }
    }
    res = res " " cnt
    gsub(/^ +/,"",res)
    return res
}

function ord(ch, ofs)
{
    if (ch == "\t") return 9
    if (ch == "\n") return 13
#   if (ch == "@") return 64
    ofs = index(" !\"#$%&'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\\\]^_`abcdefghijklmnopqrstuvwxyz{|}~", ch)
    return ofs ? 31 + ofs : 0
}

function pp(s,  res, N,arr,i)
{
    res = ""
    N = split(read(s), arr, " ")
    if (substr(s,1,1) == "w") {
        res = "(function /" arr[1] ""
        i = 2
    } else {
        res = "(applications"
        i = 1
    }
    for (; i<=N; i+=2) {
        res = res sprintf(" (%d, %d)", arr[i], arr[i+1])
    }
    return res ")"
}
