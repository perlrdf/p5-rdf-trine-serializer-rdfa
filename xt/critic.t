use Test::Perl::Critic(-exclude => [
												'RequireFinalReturn',
												'ProhibitPackageVars'
											  ],
							  -severity => 3);
all_critic_ok();
