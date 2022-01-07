// Entry point for the build script in your package.json
import "@hotwired/turbo-rails"
import "./controllers"
import { external_message, result } from "./external"
import { add } from "./calculator"

console.log(external_message)
console.log(result())
const addition = add(3,10)
console.log(addition)