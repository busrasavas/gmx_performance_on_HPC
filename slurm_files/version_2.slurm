#!/bin/bash
#SBATCH -p levrekv2-cuda
#SBATCH -A bsavas
#SBATCH -J levrek_sys
#SBATCH -N 1
#SBATCH -n 24
#SBATCH --gres=gpu:1
#SBATCH --time=15-00:00:00
#SBATCH --mail-type=ALL
#SBATCH --mail-user=buusrasavas@gmail.com
#SBATCH --output=DNMT3a-%j.out
#SBATCH --error=DNMT3a-%j.err


source /etc/profile.d/modules.sh
module load centos7.3/app/gromacs/5.1.4-openmpi-1.8.8-gcc-4.8.5-E5V3-cuda
module load  centos7.3/lib/cuda/10.0

module load centos7.3/lib/openmpi/1.8.8-gcc-4.8.5
module load centos7.3/lib/acml/6.1.0-gfortan64

export OMP_NUM_THREADS=20
echo "SLURM_NODELIST $SLURM_NODELIST"
echo "NUMBER OF CORES $SLURM_NTASKS"

$GROMACS_DIR/bin/gmx_mpi grompp -v -f 06_md_PME.mdp -c complex-NPT-noPR.gro -p complex.top -o complex_md.tpr  -r complex-NPT-noPR.tpr
$GROMACS_DIR/bin/gmx_mpi mdrun -v -deffnm complex_md -pin on

exit
