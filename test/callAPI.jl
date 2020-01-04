using RoadRunner
#println("in the callAPI file: ", rrlib)

RoadRunner.setConfigInt("LOADSBMLOPTIONS_CONSERVED_MOIETIES", 1)
#rrlib = Libdl.dlopen("C:/vs_rebuild/install/roadrunner/bin/roadrunner_c_api.dll")
ant_str = """
    const Xo, X1
     Xo -> S1; k1*Xo - k2*S1
     S1 -> S2; k3*S2
     S2 -> X1; k4*S2

     Xo = 1;   X1 = 0
     S1 = 0;   S2 = 0
     k1 = 0.1; k2 = 0.56
     k3 = 1.2; k4 = 0.9
"""
rr = loada(ant_str)
println("conserved moieties: ", RoadRunner.getConfigInt("LOADSBMLOPTIONS_CONSERVED_MOIETIES"))
data = simulate(rr, 0, 50, 51)
println(data)
ss = steadyState(rr)
println("this is the steady state value: ", ss)
ssValues = RoadRunner.computeSteadyStateValues(rr)
# str = RoadRunner.getListOfConfigKeys()
ids = getFloatingSpeciesIds(rr)
println(ids)


sbmlFile = "C:/Users/lukez/OneDrive/Desktop/Network Generator/Network-Generator/minimal.xml"
f = open(sbmlFile)
sbmlStr = read(f,String)
close(f)

rr = createRRInstance()         # Start up roadRunner
RoadRunner.loadSBML(rr, sbmlStr)
RoadRunner.addCompartment(rr, "compartment", 1.0, false)
RoadRunner.addSpecies(rr, "S1", "compartment", 0.1, "concentration", false)
RoadRunner.addSpecies(rr, "S2", "compartment", 0.1, "concentration", false)
RoadRunner.addParameter(rr, "k1", 0.1, false)
RoadRunner.addSpecies(rr, "inter-S1_S2", "compartment", 0.0, "concentration", false)
RoadRunner.addReaction(rr, "J1", ["S1"], ["S2"], "k1 * S1", true)
println("Here are the floating species: ", RoadRunner.getFloatingSpeciesIds(rr))
