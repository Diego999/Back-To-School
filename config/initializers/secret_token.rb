# This works but it's not secure ! ( kept there for study purpose )
# BackToSchool::Application.config.secret_key_base = '1c3839b3be3aae73037e42f3ea0be34312c1faa139f0532ff29dda45863fe878506a8d01ca0690c78ecdfa8fe786320a3386168d8cd65211ebb9437085b270c2'

# This is much more secure ! It uses the token loaded before.
BackToSchool::Application.config.secret_key_base = APP_CONFIG[:secret_token]
