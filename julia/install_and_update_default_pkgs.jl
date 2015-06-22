if length(ARGS) != 1
  println("Usage install_and_update_default_pkgs.jl DefaultPkgs.txt");
  exit(1);
end

# `beginswith` is deprecated in v0.4.0
if isdefined(:startswith)
  prefix_f = startswith;
else
  prefix_f = beginswith;
end

add = Array(ASCIIString, 0);
rm = Array(ASCIIString, 0);
clone = Array(ASCIIString, 0);

currls = add;

println("Parsing input file ", ARGS[1], " ...");
const f = open(ARGS[1]);
try
  while !eof(f)
    line = readline(f);
    print(line);

    i = start(search(line, "#"));
    if i != 0
      pname = strip(line[1:i-1]);
    else
      pname = strip(line);
    end

    if pname == ""; continue; end
    if prefix_f(pname, ".")
      if pname == ".update"
        Pkg.update();
      elseif pname == ".add"
        currls = add;
      elseif pname == ".rm"
        currls = rm;
      elseif pname == ".clone"
        currls = clone;
      else
        warn("`$pname` command is not understood");
      end
      continue;
    end

    push!(currls, pname);
  end
finally
  close(f);
end

println();
println("Adding... ", add);
println("Cloning... ", clone);
println("Removing... ", rm);
println();

for a in add
  try
    Pkg.add(a);
  catch e
    showerror(STDERR, e);
    println();
    warn("$a not added.");
  end
end

for r in rm
  try
    Pkg.rm(r);
  catch e
    showerror(STDERR, e);
    println();
    warn("$r not added.");
  end
end

for c in clone
  try
    Pkg.clone(c);
  catch e
    showerror(STDERR, e);
    println();
    warn("$c not added.");
  end
end

