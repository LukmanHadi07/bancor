{{-- @include('components.layouts.auth_components.header_auth') --}}
@include('components.layouts.auth_components.header_auth')
<body>
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
                                        <h1 class="h4 text-gray-900 mb-4">Bancor Login</h1>
                                    </div>
                                    <form method="POST" action="{{ route('login') }}" class="needs-validation" novalidate>
                                        @csrf
                                        <div class="form-group">
                                            <input type="email" 
                                                id="email" aria-describedby="email"
                                                placeholder="Enter Email Address..."  class="form-control @error('email')
                                                is-invalid
                                            @enderror"
                                                name="email" tabindex="1" autofocus>
                                            @error('email')
                                                <div class="invalid-feedback">
                                                    {{ $message }}
                                                </div>
                                            @enderror
                                        </div>
                                        <div class="form-group">
                                            <input type="password" id="Password" placeholder="Password" class="form-control @error('Password')
                                            is-invalid
                                        @enderror"
                                            name="password">
                                        @error('Password')
                                            <div class="invalid-feedback">
                                                {{ $message }}
                                            </div>
                                        @enderror
                                           
                                        </div>
                                       <hr>
                                        <div class="form-group">
                                            <button type="submit" class="btn btn-primary btn-lg btn-block">
                                                Login
                                            </button>
                                        </div>
                                    </form>
                                    <hr>
                                    <div class="text-center">
                                      
                                    </div>
                                    <div class="text-center">
                                     <a class="small" href="{{ route('register') }}">Create an Account!</a>
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