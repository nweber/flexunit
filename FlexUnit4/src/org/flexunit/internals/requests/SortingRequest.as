/**
 * Copyright (c) 2009 Digital Primates IT Consulting Group
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 * 
 * @author     Michael Labriola 
 * @version    
 **/ 
package org.flexunit.internals.requests
{
	import org.flexunit.runner.IRequest;
	import org.flexunit.runner.IRunner;
	import org.flexunit.runner.Request;
	import org.flexunit.runner.manipulation.Sorter;
	
	/**
	 * A <code>Request</code> that sorts the ordering in a test class.
	 */
	public class SortingRequest extends Request
	{
		/**
		 * @private
		 */
		private var request:IRequest;
		/**
		 * @private
		 */
		private var comparator:Function;
		
		/**
		 * Constructor.
		 * 
		 * Creates a sorted Request.
		 * 
		 * @param request An <code>IRequest</code> describing the tests.
		 * @param comparator The <code>Function</code> to apply to the tests described in request.
		 */
		public function SortingRequest(request:IRequest, comparator:Function)
		{
			super();
			this.request = request;
			this.comparator = comparator;
		}
		
		//TODO: Unsure of meaning and applicability of @inheritDoc
		public override function get iRunner():IRunner {
			var runner:IRunner = request.iRunner;
			new Sorter(comparator).apply(runner);
			return runner;
		}

	}
}