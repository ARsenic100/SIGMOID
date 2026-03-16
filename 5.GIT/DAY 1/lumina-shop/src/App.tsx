import { ShoppingCart, Search, Menu, X, Star, ArrowRight, Facebook, Instagram, Twitter, Mail, Phone, MapPin, ChevronRight } from 'lucide-react';
import { motion, AnimatePresence } from 'motion/react';
import { useState, useEffect } from 'react';

// --- Types ---
interface Product {
  id: number;
  name: string;
  price: number;
  rating: number;
  image: string;
  category: string;
}

interface Testimonial {
  id: number;
  name: string;
  role: string;
  content: string;
  avatar: string;
}

// --- Mock Data ---
const FEATURED_PRODUCTS: Product[] = [
  { id: 1, name: "Premium Wireless Headphones", price: 299.99, rating: 4.8, image: "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=600", category: "Electronics" },
  { id: 2, name: "Minimalist Leather Watch", price: 150.00, rating: 4.5, image: "https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=600", category: "Fashion" },
  { id: 3, name: "Smart Home Assistant", price: 129.00, rating: 4.7, image: "https://images.unsplash.com/photo-1589492477829-5e65395b66cc?auto=format&fit=crop&q=80&w=600", category: "Electronics" },
  { id: 4, name: "Ergonomic Office Chair", price: 450.00, rating: 4.9, image: "https://images.unsplash.com/photo-1505843490538-5133c6c7d0e1?auto=format&fit=crop&q=80&w=600", category: "Home Essentials" },
];

const TESTIMONIALS: Testimonial[] = [
  { id: 1, name: "Sarah Johnson", role: "Tech Enthusiast", content: "Lumina has completely changed how I shop for gadgets. The quality is always top-notch and delivery is lightning fast.", avatar: "https://i.pravatar.cc/150?u=sarah" },
  { id: 2, name: "Michael Chen", role: "Interior Designer", content: "The home essentials collection is curated with such good taste. My clients always ask where I find these pieces.", avatar: "https://i.pravatar.cc/150?u=michael" },
  { id: 3, name: "Emma Davis", role: "Fashion Blogger", content: "I love the minimalist aesthetic of their fashion line. It's affordable luxury at its best.", avatar: "https://i.pravatar.cc/150?u=emma" },
];

const CATEGORIES = [
  { name: "Electronics", image: "https://images.unsplash.com/photo-1498049794561-7780e7231661?auto=format&fit=crop&q=80&w=600", count: "120+ Products" },
  { name: "Fashion", image: "https://images.unsplash.com/photo-1445205170230-053b83016050?auto=format&fit=crop&q=80&w=600", count: "350+ Products" },
  { name: "Home Essentials", image: "https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&q=80&w=600", count: "80+ Products" },
];

// --- Components ---

const Header = () => {
  const [isScrolled, setIsScrolled] = useState(false);
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  useEffect(() => {
    const handleScroll = () => setIsScrolled(window.scrollY > 20);
    window.addEventListener('scroll', handleScroll);
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  return (
    <header className={`fixed top-0 left-0 right-0 z-50 transition-all duration-300 ${isScrolled ? 'bg-white/80 backdrop-blur-md shadow-sm py-3' : 'bg-transparent py-5'}`}>
      <div className="max-w-7xl mx-auto px-4 md:px-8 flex items-center justify-between">
        {/* Logo */}
        <div className="flex items-center gap-2">
          <div className="w-10 h-10 bg-zinc-900 rounded-full flex items-center justify-center">
            <span className="text-white font-serif font-bold text-xl">L</span>
          </div>
          <span className="text-xl font-serif font-bold tracking-tight hidden sm:block">Lumina</span>
        </div>

        {/* Desktop Nav */}
        <nav className="hidden md:flex items-center gap-8">
          {['Shop', 'Categories', 'Deals', 'About'].map((item) => (
            <a key={item} href={`#${item.toLowerCase()}`} className="text-sm font-medium text-zinc-600 hover:text-zinc-900 transition-colors">
              {item}
            </a>
          ))}
        </nav>

        {/* Actions */}
        <div className="flex items-center gap-4">
          <div className="relative hidden sm:block">
            <Search className="absolute left-3 top-1/2 -translate-y-1/2 w-4 h-4 text-zinc-400" />
            <input 
              type="text" 
              placeholder="Search products..." 
              className="pl-10 pr-4 py-2 bg-zinc-100 border-none rounded-full text-sm focus:ring-2 focus:ring-zinc-900 transition-all w-48 lg:w-64"
            />
          </div>
          <button className="relative p-2 hover:bg-zinc-100 rounded-full transition-colors">
            <ShoppingCart className="w-5 h-5" />
            <span className="absolute top-0 right-0 w-4 h-4 bg-zinc-900 text-white text-[10px] flex items-center justify-center rounded-full">3</span>
          </button>
          <button 
            className="md:hidden p-2 hover:bg-zinc-100 rounded-full transition-colors"
            onClick={() => setIsMobileMenuOpen(true)}
          >
            <Menu className="w-5 h-5" />
          </button>
        </div>
      </div>

      {/* Mobile Menu */}
      <AnimatePresence>
        {isMobileMenuOpen && (
          <motion.div 
            initial={{ opacity: 0, x: '100%' }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: '100%' }}
            className="fixed inset-0 bg-white z-[60] p-8 flex flex-col"
          >
            <div className="flex justify-between items-center mb-12">
              <span className="text-2xl font-serif font-bold">Lumina</span>
              <button onClick={() => setIsMobileMenuOpen(false)}>
                <X className="w-8 h-8" />
              </button>
            </div>
            <nav className="flex flex-col gap-8">
              {['Shop', 'Categories', 'Deals', 'About'].map((item) => (
                <a 
                  key={item} 
                  href={`#${item.toLowerCase()}`} 
                  className="text-3xl font-serif font-medium"
                  onClick={() => setIsMobileMenuOpen(false)}
                >
                  {item}
                </a>
              ))}
            </nav>
          </motion.div>
        )}
      </AnimatePresence>
    </header>
  );
};

const Hero = () => {
  return (
    <section className="relative h-screen min-h-[700px] flex items-center overflow-hidden bg-zinc-50">
      <div className="absolute inset-0 z-0">
        <img 
          src="https://images.unsplash.com/photo-1441986300917-64674bd600d8?auto=format&fit=crop&q=80&w=1920" 
          alt="Hero Background" 
          className="w-full h-full object-cover opacity-20"
          referrerPolicy="no-referrer"
        />
        <div className="absolute inset-0 bg-gradient-to-r from-zinc-50 via-zinc-50/80 to-transparent" />
      </div>

      <div className="relative z-10 max-w-7xl mx-auto px-4 md:px-8 w-full">
        <motion.div 
          initial={{ opacity: 0, y: 30 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ duration: 0.8 }}
          className="max-w-2xl"
        >
          <span className="inline-block px-4 py-1.5 bg-zinc-900 text-white text-xs font-bold tracking-widest uppercase rounded-full mb-6">
            New Collection 2026
          </span>
          <h1 className="text-6xl md:text-8xl font-serif font-bold leading-[0.9] mb-8 tracking-tight">
            Elevate Your <br />
            <span className="text-zinc-400 italic">Everyday</span> Style.
          </h1>
          <p className="text-lg text-zinc-600 mb-10 max-w-lg leading-relaxed">
            Discover our curated selection of premium essentials designed for the modern lifestyle. Quality meets minimalism in every piece.
          </p>
          <div className="flex flex-wrap gap-4">
            <button className="px-8 py-4 bg-zinc-900 text-white rounded-full font-medium hover:bg-zinc-800 transition-all flex items-center gap-2 group">
              Shop Now
              <ArrowRight className="w-4 h-4 group-hover:translate-x-1 transition-transform" />
            </button>
            <button className="px-8 py-4 border border-zinc-200 rounded-full font-medium hover:bg-white transition-all">
              View Lookbook
            </button>
          </div>
        </motion.div>
      </div>

      {/* Floating Elements */}
      <motion.div 
        animate={{ y: [0, -20, 0] }}
        transition={{ duration: 4, repeat: Infinity, ease: "easeInOut" }}
        className="absolute top-1/4 right-[10%] hidden lg:block w-64 h-80 rounded-2xl overflow-hidden shadow-2xl rotate-6"
      >
        <img src="https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&q=80&w=600" alt="Featured 1" className="w-full h-full object-cover" referrerPolicy="no-referrer" />
      </motion.div>
      <motion.div 
        animate={{ y: [0, 20, 0] }}
        transition={{ duration: 5, repeat: Infinity, ease: "easeInOut", delay: 1 }}
        className="absolute bottom-1/4 right-[25%] hidden lg:block w-48 h-64 rounded-2xl overflow-hidden shadow-2xl -rotate-12"
      >
        <img src="https://images.unsplash.com/photo-1505740420928-5e560c06d30e?auto=format&fit=crop&q=80&w=600" alt="Featured 2" className="w-full h-full object-cover" referrerPolicy="no-referrer" />
      </motion.div>
    </section>
  );
};

const Categories = () => {
  return (
    <section id="categories" className="py-24 bg-white">
      <div className="max-w-7xl mx-auto px-4 md:px-8">
        <div className="flex justify-between items-end mb-12">
          <div>
            <h2 className="text-4xl font-serif font-bold mb-4">Shop by Category</h2>
            <p className="text-zinc-500">Explore our diverse range of curated collections.</p>
          </div>
          <button className="hidden sm:flex items-center gap-2 text-sm font-bold uppercase tracking-widest hover:gap-4 transition-all">
            View All <ChevronRight className="w-4 h-4" />
          </button>
        </div>

        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          {CATEGORIES.map((category, idx) => (
            <motion.div 
              key={category.name}
              whileHover={{ y: -10 }}
              className="group relative h-[400px] rounded-3xl overflow-hidden cursor-pointer"
            >
              <img src={category.image} alt={category.name} className="w-full h-full object-cover transition-transform duration-700 group-hover:scale-110" referrerPolicy="no-referrer" />
              <div className="absolute inset-0 bg-gradient-to-t from-black/80 via-black/20 to-transparent" />
              <div className="absolute bottom-8 left-8">
                <p className="text-zinc-300 text-xs font-bold uppercase tracking-widest mb-2">{category.count}</p>
                <h3 className="text-2xl text-white font-serif font-bold">{category.name}</h3>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};

const FeaturedProducts = () => {
  return (
    <section id="shop" className="py-24 bg-zinc-50">
      <div className="max-w-7xl mx-auto px-4 md:px-8">
        <div className="text-center max-w-2xl mx-auto mb-16">
          <h2 className="text-4xl font-serif font-bold mb-4">Featured Products</h2>
          <p className="text-zinc-500">Our most loved pieces, handpicked for you based on quality and design excellence.</p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-8">
          {FEATURED_PRODUCTS.map((product) => (
            <motion.div 
              key={product.id}
              initial={{ opacity: 0, y: 20 }}
              whileInView={{ opacity: 1, y: 0 }}
              viewport={{ once: true }}
              className="group"
            >
              <div className="relative aspect-[4/5] rounded-2xl overflow-hidden bg-white mb-4">
                <img src={product.image} alt={product.name} className="w-full h-full object-cover transition-transform duration-500 group-hover:scale-105" referrerPolicy="no-referrer" />
                <button className="absolute bottom-4 left-4 right-4 py-3 bg-white/90 backdrop-blur-sm text-zinc-900 text-sm font-bold rounded-xl opacity-0 translate-y-4 group-hover:opacity-100 group-hover:translate-y-0 transition-all duration-300">
                  Add to Cart
                </button>
                <div className="absolute top-4 right-4 p-2 bg-white/90 backdrop-blur-sm rounded-full opacity-0 group-hover:opacity-100 transition-opacity">
                  <Star className="w-4 h-4 text-yellow-500 fill-yellow-500" />
                </div>
              </div>
              <p className="text-xs text-zinc-400 font-bold uppercase tracking-widest mb-1">{product.category}</p>
              <h3 className="font-medium text-zinc-900 mb-1">{product.name}</h3>
              <div className="flex items-center justify-between">
                <span className="font-bold text-lg">${product.price.toFixed(2)}</span>
                <div className="flex items-center gap-1">
                  <Star className="w-3 h-3 text-yellow-500 fill-yellow-500" />
                  <span className="text-xs font-medium text-zinc-500">{product.rating}</span>
                </div>
              </div>
            </motion.div>
          ))}
        </div>
      </div>
    </section>
  );
};

const SpecialOffers = () => {
  return (
    <section id="deals" className="py-24">
      <div className="max-w-7xl mx-auto px-4 md:px-8">
        <div className="bg-zinc-900 rounded-[3rem] overflow-hidden relative">
          <div className="grid grid-cols-1 lg:grid-cols-2">
            <div className="p-12 md:p-20 flex flex-col justify-center">
              <span className="text-emerald-400 font-bold tracking-widest uppercase text-xs mb-6">Limited Time Offer</span>
              <h2 className="text-4xl md:text-6xl text-white font-serif font-bold mb-8 leading-tight">
                Get <span className="text-emerald-400 italic">30% Off</span> on <br />
                Your First Order.
              </h2>
              <p className="text-zinc-400 mb-10 text-lg max-w-md">
                Join the Lumina community today and enjoy exclusive access to new drops and seasonal sales.
              </p>
              <div className="flex items-center gap-6">
                <button className="px-8 py-4 bg-white text-zinc-900 rounded-full font-bold hover:bg-zinc-100 transition-all">
                  Claim Discount
                </button>
                <span className="text-white font-mono text-sm tracking-widest">CODE: LUMINA30</span>
              </div>
            </div>
            <div className="relative h-[400px] lg:h-auto">
              <img 
                src="https://images.unsplash.com/photo-1483985988355-763728e1935b?auto=format&fit=crop&q=80&w=1000" 
                alt="Special Offer" 
                className="w-full h-full object-cover"
                referrerPolicy="no-referrer"
              />
              <div className="absolute inset-0 bg-gradient-to-r from-zinc-900 via-transparent to-transparent" />
            </div>
          </div>
        </div>
      </div>
    </section>
  );
};

const Testimonials = () => {
  return (
    <section className="py-24 bg-zinc-50 overflow-hidden">
      <div className="max-w-7xl mx-auto px-4 md:px-8">
        <div className="text-center mb-16">
          <h2 className="text-4xl font-serif font-bold mb-4">What Our Clients Say</h2>
          <p className="text-zinc-500">Real stories from real customers who love Lumina.</p>
        </div>

        <div className="flex gap-8 overflow-x-auto pb-8 no-scrollbar snap-x">
          {TESTIMONIALS.map((t) => (
            <div key={t.id} className="min-w-[350px] md:min-w-[400px] bg-white p-10 rounded-3xl shadow-sm snap-center">
              <div className="flex gap-1 mb-6">
                {[...Array(5)].map((_, i) => <Star key={i} className="w-4 h-4 text-yellow-500 fill-yellow-500" />)}
              </div>
              <p className="text-lg text-zinc-700 italic mb-8 leading-relaxed">"{t.content}"</p>
              <div className="flex items-center gap-4">
                <img src={t.avatar} alt={t.name} className="w-12 h-12 rounded-full object-cover" referrerPolicy="no-referrer" />
                <div>
                  <h4 className="font-bold text-zinc-900">{t.name}</h4>
                  <p className="text-sm text-zinc-400">{t.role}</p>
                </div>
              </div>
            </div>
          ))}
        </div>
      </div>
    </section>
  );
};

const Newsletter = () => {
  return (
    <section className="py-24 bg-white">
      <div className="max-w-3xl mx-auto px-4 text-center">
        <div className="w-16 h-16 bg-zinc-100 rounded-2xl flex items-center justify-center mx-auto mb-8">
          <Mail className="w-8 h-8 text-zinc-900" />
        </div>
        <h2 className="text-4xl font-serif font-bold mb-4">Join the Newsletter</h2>
        <p className="text-zinc-500 mb-10">Subscribe to receive updates, access to exclusive deals, and more.</p>
        <form className="flex flex-col sm:flex-row gap-4" onSubmit={(e) => e.preventDefault()}>
          <input 
            type="email" 
            placeholder="Enter your email address" 
            className="flex-1 px-6 py-4 bg-zinc-100 border-none rounded-2xl focus:ring-2 focus:ring-zinc-900 transition-all"
            required
          />
          <button className="px-8 py-4 bg-zinc-900 text-white rounded-2xl font-bold hover:bg-zinc-800 transition-all">
            Subscribe Now
          </button>
        </form>
        <p className="mt-6 text-xs text-zinc-400">By subscribing, you agree to our Privacy Policy and Terms of Service.</p>
      </div>
    </section>
  );
};

const Footer = () => {
  return (
    <footer className="bg-zinc-900 text-white pt-24 pb-12">
      <div className="max-w-7xl mx-auto px-4 md:px-8">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-12 mb-16">
          {/* Brand */}
          <div>
            <div className="flex items-center gap-2 mb-8">
              <div className="w-10 h-10 bg-white rounded-full flex items-center justify-center">
                <span className="text-zinc-900 font-serif font-bold text-xl">L</span>
              </div>
              <span className="text-2xl font-serif font-bold tracking-tight">Lumina</span>
            </div>
            <p className="text-zinc-400 leading-relaxed mb-8">
              Curating the finest essentials for the modern lifestyle. Quality, minimalism, and elegance in every piece.
            </p>
            <div className="flex gap-4">
              {[Instagram, Twitter, Facebook].map((Icon, i) => (
                <a key={i} href="#" className="w-10 h-10 rounded-full border border-zinc-700 flex items-center justify-center hover:bg-white hover:text-zinc-900 transition-all">
                  <Icon className="w-5 h-5" />
                </a>
              ))}
            </div>
          </div>

          {/* Quick Links */}
          <div>
            <h4 className="font-bold mb-8 uppercase tracking-widest text-xs">Quick Links</h4>
            <ul className="space-y-4">
              {['New Arrivals', 'Best Sellers', 'Shop All', 'Gift Cards', 'Lookbook'].map(item => (
                <li key={item}><a href="#" className="text-zinc-400 hover:text-white transition-colors">{item}</a></li>
              ))}
            </ul>
          </div>

          {/* Support */}
          <div>
            <h4 className="font-bold mb-8 uppercase tracking-widest text-xs">Support</h4>
            <ul className="space-y-4">
              {['Shipping Policy', 'Returns & Exchanges', 'FAQs', 'Contact Us', 'Privacy Policy'].map(item => (
                <li key={item}><a href="#" className="text-zinc-400 hover:text-white transition-colors">{item}</a></li>
              ))}
            </ul>
          </div>

          {/* Contact */}
          <div>
            <h4 className="font-bold mb-8 uppercase tracking-widest text-xs">Contact Us</h4>
            <ul className="space-y-6">
              <li className="flex gap-4">
                <Phone className="w-5 h-5 text-zinc-500 shrink-0" />
                <span className="text-zinc-400">+1 (555) 000-LUMINA</span>
              </li>
              <li className="flex gap-4">
                <Mail className="w-5 h-5 text-zinc-500 shrink-0" />
                <span className="text-zinc-400">hello@lumina.shop</span>
              </li>
            </ul>
          </div>
        </div>

        <div className="pt-12 border-t border-zinc-800 flex flex-col md:flex-row justify-between items-center gap-6">
          <p className="text-zinc-500 text-sm">© 2026 Lumina Shop. All rights reserved.</p>
          <div className="flex gap-8">
            <img src="https://upload.wikimedia.org/wikipedia/commons/5/5e/Visa_Inc._logo.svg" alt="Visa" className="h-4 opacity-50 grayscale hover:grayscale-0 transition-all" />
            <img src="https://upload.wikimedia.org/wikipedia/commons/2/2a/Mastercard-logo.svg" alt="Mastercard" className="h-6 opacity-50 grayscale hover:grayscale-0 transition-all" />
            <img src="https://upload.wikimedia.org/wikipedia/commons/b/b5/PayPal.svg" alt="Paypal" className="h-5 opacity-50 grayscale hover:grayscale-0 transition-all" />
          </div>
        </div>
      </div>
    </footer>
  );
};

export default function App() {
  return (
    <div className="min-h-screen selection:bg-zinc-900 selection:text-white">
      <Header />
      <main>
        <Hero />
        <Categories />
        <FeaturedProducts />
        <SpecialOffers />
        <Testimonials />
        <Newsletter />
      </main>
      <Footer />
    </div>
  );
}
