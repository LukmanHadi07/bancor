@include('components.layouts.auth_components.header_auth')

<body >
    <br>
    <br>
    <br>
    <div class="container">
        <!-- Outer Row -->
        <div class="row justify-content-center">
            <div class="col-xl-10 col-lg-12 col-md-9">
                <div class="card o-hidden border-0 shadow-lg my-5">
                    <div class="card-body p-0">
                        <!-- Nested Row within Card Body -->
                        <div class="row">
                            <div class="col-lg-6 d-flex justify-content-center align-items-center">
                                <img src="assets/img/LOGO.png" alt="Logo" class="img-fluid">
                            </div>
                            <div class="col-lg-6">
                                <div class="p-5">
                                    <div class="text-center">
                                        <h1 class="h4 text-gray-900 mb-4">Register Admin Bancor</h1>
                                    </div>
                                    <form method="POST">
                                        @csrf
                                        <div class="form-group">
                                            <input type="text" 
                                                id="name" aria-describedby="name"
                                                placeholder="Enter Name"  class="form-control @error('name')
                                                is-invalid
                                            @enderror"
                                                name="name" autofocus>
                                            @error('name')
                                                <div class="invalid-feedback">
                                                    {{ $message }}
                                                </div>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <input type="email" 
                                                id="email" aria-describedby="email"
                                                placeholder="Enter Email Address..."  class="form-control @error('email')
                                                is-invalid
                                            @enderror"
                                                name="email">
                                            <div class="invalid-feedback">
                                            </div>
                                            @error('email')
                                                <div class="invalid-feedback">
                                                    {{ $message }}
                                                </div>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <input type="password"  id="Password" placeholder="Password"  class="form-control @error('Password')
                                            is-invalid
                                        @enderror"
                                            name="password">
                                        @error('Password')
                                            <div class="invalid-feedback">
                                                {{ $message }}
                                            </div>
                                        @enderror
                                        </div>
                                        <div class="form-group">
                                            <input type="password" class="form-control form-control-user" id="Password2" placeholder="Confirm Password" name="password_confirmation">
                                        </div>
                                        
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-primary btn-lg btn-block">
                                                Register
                                            </button>
                                        </div>
                                    </form>
                                    <hr>
                                    
                                    <div class="text-center">
                                        Have account ? <a class="small" href="{{ route('login') }}"> Login </a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    @include('components.layouts.auth_components.footer_auth')