require 'spec_helper'

describe SolvingStep do
	let(:step) { SolvingStep.new }

	 it { should validate_presence_of :step }
	 it { should belong_to(:service_event) }
	 it { should belong_to(:user) }

	 it "has description column" do
		desc = "There are two syntaxes available for Sass. 
							The first, known as SCSS (Sassy CSS) and 
							used throughout this reference, is an
							extension of the syntax of CSS3.
							This means that every valid CSS3 stylesheet 
							is a valid SCSS file with the same meaning.
							In addition, SCSS understands most CSS hacks
							and vendor-specific syntax, such as IE’s old
							filter syntax. This syntax is enhanced with the
							Sass features described below. Files using this
							syntax have the .scss extension."
		step.description = desc
		expect(step.description).to eq(desc)
	 end
end
