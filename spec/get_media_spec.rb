require 'ElevatorMedia'


describe Streamer do
    describe '.getContent' do
        context 'test for morning text between 00:00 and noon' do
            it 'returns Morning Text ' do                
                expect(Streamer.getContent(6)[0]).to eq('<div> morning text </div>')
            end
        end     
        context 'test for afternoon text between noon and midnight' do
            it 'returns afternoon Text ' do                
                expect(Streamer.getContent(16)[0]).to eq('<div> afternoon text </div>')
            end
        end 
        context 'test for morning video between midning and noon' do
            it 'returns morning video ' do                
                expect(Streamer.getContent(6)[1]).to eq('<div> morning video </div>')
            end
        end
        context 'test for afternoon video between noon and midnight ' do
            it 'returns morning video ' do                
                expect(Streamer.getContent(16)[1]).to eq('<div> afternoon video </div>')
            end
        end      
    end
end